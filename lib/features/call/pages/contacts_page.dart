import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_spacing.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _isLoading = true;
  bool _permissionDenied = false;
  String _currentVisibleSection = 'ㄱ'; // 기본값을 한국어 첫 번째 초성으로 설정
  bool _isNavigatorDragging = false;
  String _draggedLetter = '';
  Timer? _hideTimer;

  // 각 섹션의 GlobalKey를 저장
  final Map<String, GlobalKey> _sectionKeys = {};
  // 네비게이터 GlobalKey
  final GlobalKey _navigatorKey = GlobalKey();

  // 알파벳 인덱스 리스트
  final List<String> _alphabetIndex = [
    'ㄱ',
    'ㄴ',
    'ㄷ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅅ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '#',
  ];

  @override
  void initState() {
    super.initState();
    _initializeSectionKeys();
    _loadContacts();
  }

  void _initializeSectionKeys() {
    for (final letter in _alphabetIndex) {
      _sectionKeys[letter] = GlobalKey();
    }
  }

  void _updateCurrentVisibleSection() {
    if (!mounted) return;

    final groupedContacts = _groupContacts();
    final sections = groupedContacts.keys.toList()
      ..sort((a, b) {
        final aIndex = _alphabetIndex.indexOf(a);
        final bIndex = _alphabetIndex.indexOf(b);
        if (aIndex == -1) return 1;
        if (bIndex == -1) return -1;
        return aIndex.compareTo(bIndex);
      });

    if (sections.isEmpty) return;

    // 현재 화면에 보이는 섹션들을 찾기
    final newVisibleSections = <String>{};
    String? topMostSection;

    for (final section in sections) {
      final sectionKey = _sectionKeys[section];
      if (sectionKey?.currentContext != null) {
        final renderObject = sectionKey!.currentContext!.findRenderObject();
        if (renderObject is RenderBox) {
          final position = renderObject.localToGlobal(Offset.zero);
          final size = renderObject.size;

          // 화면에 보이는지 확인 (AppBar 높이 고려)
          final appBarHeight =
              AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top;
          final isVisible =
              position.dy < MediaQuery.of(context).size.height &&
              position.dy + size.height > appBarHeight;

          if (isVisible) {
            newVisibleSections.add(section);
            topMostSection ??= section;
          }
        }
      }
    }

    if (topMostSection != null && _currentVisibleSection != topMostSection) {
      setState(() {
        _currentVisibleSection = topMostSection!;
      });
    } else {
      // 현재 섹션이 바뀌지 않아도 섹션 헤더 가시성 업데이트
      setState(() {});
    }
  }

  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });

    // 연락처 권한 확인
    final status = await Permission.contacts.status;
    if (!status.isGranted) {
      final result = await Permission.contacts.request();
      if (!result.isGranted) {
        setState(() {
          _permissionDenied = true;
          _isLoading = false;
        });
        return;
      }
    }

    try {
      // 실제 연락처 가져오기
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );

      // 이름순으로 정렬
      contacts.sort((a, b) {
        final aName = a.displayName;
        final bName = b.displayName;
        return aName.compareTo(bName);
      });

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
        _isLoading = false;

        // 최초 로딩 완료 후 첫 번째 섹션으로 초기화
        _initializeCurrentSection();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeCurrentSection() {
    final groupedContacts = _groupContacts();
    if (groupedContacts.isNotEmpty) {
      final sections = groupedContacts.keys.toList()
        ..sort((a, b) {
          final aIndex = _alphabetIndex.indexOf(a);
          final bIndex = _alphabetIndex.indexOf(b);
          if (aIndex == -1) return 1;
          if (bIndex == -1) return -1;
          return aIndex.compareTo(bIndex);
        });

      if (sections.isNotEmpty) {
        _currentVisibleSection = sections.first;
      }
    }
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredContacts = _contacts;
        // 필터 제거 후 다시 초기화
        _initializeCurrentSection();
      });
    } else {
      setState(() {
        _filteredContacts = _contacts.where((contact) {
          final name = contact.displayName.toLowerCase();
          final phone = contact.phones.isNotEmpty
              ? contact.phones.first.number.toLowerCase()
              : '';
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || phone.contains(searchQuery);
        }).toList();
        // 필터 후 초기화
        _initializeCurrentSection();
      });
    }
  }

  String _getFirstLetter(String name) {
    if (name.isEmpty) return '#';

    final firstChar = name[0];

    // 한글 체크
    if (RegExp(r'[가-힣]').hasMatch(firstChar)) {
      // 초성 추출
      final code = firstChar.codeUnitAt(0) - 0xAC00;
      final chosung = code ~/ (21 * 28);
      const chosungList = [
        'ㄱ',
        'ㄲ',
        'ㄴ',
        'ㄷ',
        'ㄸ',
        'ㄹ',
        'ㅁ',
        'ㅂ',
        'ㅃ',
        'ㅅ',
        'ㅆ',
        'ㅇ',
        'ㅈ',
        'ㅉ',
        'ㅊ',
        'ㅋ',
        'ㅌ',
        'ㅍ',
        'ㅎ',
      ];
      if (chosung >= 0 && chosung < chosungList.length) {
        final result = chosungList[chosung];
        // ㄲ, ㄸ, ㅃ, ㅆ, ㅉ는 해당 기본 자음으로 변경
        if (result == 'ㄲ') return 'ㄱ';
        if (result == 'ㄸ') return 'ㄷ';
        if (result == 'ㅃ') return 'ㅂ';
        if (result == 'ㅆ') return 'ㅅ';
        if (result == 'ㅉ') return 'ㅈ';
        return result;
      }
    }

    // 영문 체크
    if (RegExp(r'[A-Za-z]').hasMatch(firstChar)) {
      return firstChar.toUpperCase();
    }

    return '#';
  }

  Map<String, List<Contact>> _groupContacts() {
    final grouped = <String, List<Contact>>{};

    for (final contact in _filteredContacts) {
      final firstLetter = _getFirstLetter(contact.displayName);
      grouped[firstLetter] ??= [];
      grouped[firstLetter]!.add(contact);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0, // 스크롤 시 elevation 효과 제거
        titleSpacing: 8, // leading과 title 간격 축소
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: _buildSearchBar(),
        centerTitle: false, // 좌측 정렬로 변경하여 간격 활용
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    if (_permissionDenied) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contacts, size: 64, color: AppColors.textSecondary),
            SizedBox(height: 16),
            Text(
              '연락처 권한이 필요합니다',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '설정에서 연락처 권한을 허용해주세요',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => openAppSettings(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text('설정으로 이동'),
            ),
          ],
        ),
      );
    }

    final groupedContacts = _groupContacts();
    final hasContacts = groupedContacts.isNotEmpty;

    if (!hasContacts) {
      // 검색 결과가 없을 때
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
            SizedBox(height: 16),
            Text(
              '검색 결과가 없습니다',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 고정된 헤더 (컴팩한 크기로 조정)
        Container(
          color: AppColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 연락처 타이틀
              Container(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.md,
                  AppSpacing.xl,
                  AppSpacing.xs, // 하단 패딩 축소
                ),
                child: Text(
                  '연락처',
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              // 현재 그룹 섹션
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.xs, // 상단 패딩 축소
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.divider.withValues(alpha: 0.3),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Text(
                  _currentVisibleSection,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 스크롤 영역
        Expanded(
          child: Stack(
            children: [
              _buildContactsList(),
              Positioned(
                key: _navigatorKey,
                right: 0,
                top: 0,
                bottom: 0,
                child: _buildAlphabetNavigator(),
              ),
              // 네비게이터 드래그 중일 때 중앙에 현재 섹션 표시
              if (_isNavigatorDragging)
                Center(
                  child: Container(
                    width: 60, // 축소된 너비
                    height: 60, // 정사각형
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _draggedLetter.isNotEmpty
                            ? _draggedLetter
                            : _currentVisibleSection,
                        style: AppTypography.headlineMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        AppSpacing.heightXXXL,
      ],
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: '이름, 전화번호를 입력하세요',
          hintStyle: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
          prefixIcon: Container(
            width: 32,
            alignment: Alignment.centerLeft,
            child: Icon(Icons.search, color: AppColors.textSecondary, size: 28),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 32, maxWidth: 32),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          fillColor: Colors.transparent,
          filled: true,
          isDense: true, // 밀도를 높여 정렬 개선
        ),
        style: AppTypography.bodyLarge,
        onChanged: _filterContacts,
      ),
    );
  }

  Widget _buildContactsList() {
    final groupedContacts = _groupContacts();
    final sections = groupedContacts.keys.toList()
      ..sort((a, b) {
        final aIndex = _alphabetIndex.indexOf(a);
        final bIndex = _alphabetIndex.indexOf(b);
        if (aIndex == -1) return 1;
        if (bIndex == -1) return -1;
        return aIndex.compareTo(bIndex);
      });

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification ||
            notification is ScrollEndNotification) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateCurrentVisibleSection();
          });
        }
        return false;
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: _buildSlivers(sections, groupedContacts),
      ),
    );
  }

  Widget _buildAlphabetNavigator() {
    final groupedContacts = _groupContacts();

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // 전체 영역에서 터치 감지
      onPanStart: (details) {
        _handleNavigatorDragStart(details.localPosition, groupedContacts);
        setState(() {
          _isNavigatorDragging = true;
        });
        HapticFeedback.lightImpact();
      },
      onPanUpdate: (details) {
        _handleNavigatorDragUpdate(details.localPosition, groupedContacts);
      },
      onPanEnd: (details) {
        _hideTimer?.cancel();
        _hideTimer = Timer(Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              _isNavigatorDragging = false;
              _draggedLetter = '';
            });
          }
        });
      },
      child: SizedBox(
        width: 30,
        height: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final itemHeight = availableHeight / _alphabetIndex.length;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: _alphabetIndex.asMap().entries.map((entry) {
                final letter = entry.value;
                final hasContacts = groupedContacts.containsKey(letter);
                return GestureDetector(
                  onTap: hasContacts ? () => _scrollToSection(letter) : null,
                  child: SizedBox(
                    height: itemHeight,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  void _handleNavigatorDragStart(
    Offset localPosition,
    Map<String, List<Contact>> groupedContacts,
  ) {
    _handleNavigatorDragUpdate(localPosition, groupedContacts);
  }

  void _handleNavigatorDragUpdate(
    Offset localPosition,
    Map<String, List<Contact>> groupedContacts,
  ) {
    // 네비게이터 RenderBox 가져오기
    final navigatorRenderBox =
        _navigatorKey.currentContext?.findRenderObject() as RenderBox?;
    if (navigatorRenderBox == null) return;

    final navigatorHeight = navigatorRenderBox.size.height;
    final itemHeight = navigatorHeight / _alphabetIndex.length;

    // 인덱스 계산
    final exactIndex = localPosition.dy / itemHeight;
    final index = exactIndex.round().clamp(0, _alphabetIndex.length - 1);

    final letter = _alphabetIndex[index];
    if (_draggedLetter != letter) {
      setState(() {
        _draggedLetter = letter;
      });

      // 연락처가 있는 섹션만 스크롤 이동
      if (groupedContacts.containsKey(letter)) {
        _scrollToSectionWithKey(letter);
      }

      HapticFeedback.lightImpact();
    }
  }

  List<Widget> _buildSlivers(
    List<String> sections,
    Map<String, List<Contact>> groupedContacts,
  ) {
    final slivers = <Widget>[];

    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final contacts = groupedContacts[section] ?? [];

      // 섹션 헤더 (고정 헤더와 겹치는 위치에 있으면 숨김)
      slivers.add(
        SliverToBoxAdapter(
          child: _buildSectionHeader(
            section,
            _shouldHideSectionHeader(section),
          ),
        ),
      );

      // 연락처 목록
      slivers.add(
        SliverPadding(
          padding: EdgeInsets.only(right: 30), // 네비게이터 공간
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildContactItem(contacts[index]),
              childCount: contacts.length,
            ),
          ),
        ),
      );
    }

    // 하단 여백 공간 추가
    slivers.add(
      SliverToBoxAdapter(
        child: SizedBox(height: MediaQuery.of(context).padding.bottom),
      ),
    );

    return slivers;
  }

  Widget _buildSectionHeader(String section, bool shouldHide) {
    return Container(
      key: _sectionKeys[section], // GlobalKey 유지
      width: double.infinity,
      color: AppColors.surface,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 150),
        transitionBuilder: (child, animation) {
          return SizeTransition(sizeFactor: animation, child: child);
        },
        child: shouldHide
            ? SizedBox(
                key: ValueKey('${section}_hidden'),
                width: double.infinity,
                height: 0,
              )
            : Container(
                key: ValueKey('${section}_visible'),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.sm,
                ),
                child: Text(
                  section,
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }

  bool _shouldHideSectionHeader(String section) {
    // 현재 고정 헤더에 표시된 섹션과 동일한 섹션만 숨김
    return section == _currentVisibleSection;
  }

  void _scrollToSection(String letter) {
    _scrollToSectionWithKey(letter);
  }

  void _scrollToSectionWithKey(String letter) {
    final sectionKey = _sectionKeys[letter];
    if (sectionKey?.currentContext == null) return;

    // Scrollable.ensureVisible을 사용하여 정확하고 부드러운 스크롤
    Scrollable.ensureVisible(
      sectionKey!.currentContext!,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      alignment: 0.0, // 상단에 정렬
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    ).then((_) {
      // 스크롤 완료 후 현재 섹션 업데이트
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateCurrentVisibleSection();
      });
    });
  }

  Widget _buildContactItem(Contact contact) {
    final phoneNumber = contact.phones.isNotEmpty
        ? contact.phones.first.number
        : '';

    return InkWell(
      onTap: () {
        if (phoneNumber.isNotEmpty) {
          // 연락처 선택 시 전화 페이지로 돌아가며 번호 전달
          context.pop(phoneNumber);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // 프로필 아이콘
              AspectRatio(
                aspectRatio: 1, // 정사각형 유지
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                    size: 30,
                  ),
                ),
              ),
              AppSpacing.widthMD,
              // 이름, 전화번호
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      contact.displayName,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    if (phoneNumber.isNotEmpty)
                      Text(
                        phoneNumber,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
