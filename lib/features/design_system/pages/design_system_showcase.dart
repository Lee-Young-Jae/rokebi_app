import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class DesignSystemShowcase extends StatefulWidget {
  const DesignSystemShowcase({super.key});

  @override
  State<DesignSystemShowcase> createState() => _DesignSystemShowcaseState();
}

class _DesignSystemShowcaseState extends State<DesignSystemShowcase> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rokebi Design System')),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.heightXL,
            Text('Typography', style: AppTypography.headlineMedium),
            AppSpacing.heightMD,
            Text('Display Large', style: AppTypography.displayLarge),
            Text('Display Medium', style: AppTypography.displayMedium),
            Text('Display Small', style: AppTypography.displaySmall),
            Text('Headline Large', style: AppTypography.headlineLarge),
            Text('Headline Medium', style: AppTypography.headlineMedium),
            Text('Headline Small', style: AppTypography.headlineSmall),
            Text('Title Large', style: AppTypography.titleLarge),
            Text('Title Medium', style: AppTypography.titleMedium),
            Text('Title Small', style: AppTypography.titleSmall),
            Text('Body Large', style: AppTypography.bodyLarge),
            Text('Body Medium', style: AppTypography.bodyMedium),
            Text('Body Small', style: AppTypography.bodySmall),

            AppSpacing.heightXXL,
            const Divider(),
            AppSpacing.heightXXL,

            Text('Colors', style: AppTypography.headlineMedium),
            AppSpacing.heightMD,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildColorChip('Primary', AppColors.primary),
                _buildColorChip('Primary Light', AppColors.primaryLight),
                _buildColorChip('Primary Dark', AppColors.primaryDark),
                _buildColorChip('Secondary', AppColors.secondary),
                _buildColorChip('Secondary Light', AppColors.secondaryLight),
                _buildColorChip('Secondary Dark', AppColors.secondaryDark),
                _buildColorChip('Success', AppColors.success),
                _buildColorChip('Warning', AppColors.warning),
                _buildColorChip('Error', AppColors.error),
                _buildColorChip('Info', AppColors.info),
              ],
            ),

            AppSpacing.heightXXL,
            const Divider(),
            AppSpacing.heightXXL,

            Text('Buttons', style: AppTypography.headlineMedium),
            AppSpacing.heightMD,

            AppButton(
              text: 'Primary 버튼',
              onPressed: () {},
              type: AppButtonType.primary,
              isFullWidth: true,
            ),
            AppSpacing.heightMD,

            AppButton(
              text: 'Secondary 버튼',
              onPressed: () {},
              type: AppButtonType.secondary,
              isFullWidth: true,
            ),
            AppSpacing.heightMD,

            AppButton(
              text: 'Outlined 버튼',
              onPressed: () {},
              type: AppButtonType.outlined,
              isFullWidth: true,
            ),
            AppSpacing.heightMD,

            AppButton(
              text: 'Text 버튼',
              onPressed: () {},
              type: AppButtonType.text,
              isFullWidth: true,
            ),
            AppSpacing.heightMD,

            AppButton(
              text: 'Danger 버튼',
              onPressed: () {},
              type: AppButtonType.danger,
              isFullWidth: true,
            ),
            AppSpacing.heightMD,

            AppButton(
              text: 'Loading...',
              onPressed: () {},
              isLoading: true,
              isFullWidth: true,
            ),
            AppSpacing.heightMD,

            AppButton(text: 'Disabled', onPressed: null, isFullWidth: true),

            AppSpacing.heightXXL,
            const Divider(),
            AppSpacing.heightXXL,

            Text('Text Fields', style: AppTypography.headlineMedium),
            AppSpacing.heightMD,

            AppTextField(
              label: '이메일',
              hint: '이메일을 입력하세요',
              controller: _textController,
              // prefixIcon: const Icon(Icons.email),
            ),
            AppSpacing.heightMD,

            AppTextField(
              label: '비밀번호',
              hint: '비밀번호를 입력하세요',
              obscureText: true,
              // prefixIcon: const Icon(Icons.lock),
            ),
            AppSpacing.heightMD,

            AppTextField(
              label: '검색',
              hint: '검색어를 입력하세요',
              // prefixIcon: const Icon(Icons.search),
              // suffixIcon: const Icon(Icons.filter_list),
            ),
            AppSpacing.heightMD,

            AppTextField(
              label: '에러 필드',
              hint: '힌트.',
              errorText: '올바른 값을 입력하세요',
              prefixIcon: const Icon(Icons.error),
            ),

            AppSpacing.heightXXL,
            const Divider(),
            AppSpacing.heightXXL,
          ],
        ),
      ),
    );
  }

  Widget _buildColorChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
