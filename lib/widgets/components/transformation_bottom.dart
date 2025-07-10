import 'package:app/utils/style.dart';
import 'package:flutter/material.dart';

class TransformationButtons extends StatelessWidget {
  const TransformationButtons({
    required this.controller,
    this.zoomFactor = 1.1,
    this.layoutDirection = ButtonLayout.vertical,
    super.key,
  });

  final TransformationController controller;
  final double zoomFactor;
  final ButtonLayout layoutDirection;

  @override
  Widget build(BuildContext context) {
    return layoutDirection == ButtonLayout.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildButtons(),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildButtons(),
          );
  }

  List<Widget> _buildButtons() {
    return [
      Tooltip(
        message: 'Zoom in',
        child: IconButton(
          icon: const Icon(
            Icons.add,
            size: 24,
            color: AppColors.contentColorWhite,
          ),
          onPressed: _transformationZoomIn,
          tooltip: 'Zoom in',
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'Move left',
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: AppColors.contentColorWhite,
              ),
              onPressed: _transformationMoveLeft,
            ),
          ),
          Tooltip(
            message: 'Reset zoom',
            child: IconButton(
              icon: const Icon(
                Icons.refresh,
                size: 24,
                color: AppColors.contentColorWhite,
              ),
              onPressed: _transformationReset,
            ),
          ),
          Tooltip(
            message: 'Move right',
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 24,
                color: AppColors.contentColorWhite,
              ),
              onPressed: _transformationMoveRight,
            ),
          ),
        ],
      ),
      Tooltip(
        message: 'Zoom out',
        child: IconButton(
          icon: const Icon(
            Icons.minimize,
            size: 24,
            color: AppColors.contentColorWhite,
          ),
          onPressed: _transformationZoomOut,
        ),
      ),
    ];
  }

  void _transformationReset() {
    controller.value = Matrix4.identity();
  }

  void _transformationZoomIn() {
    controller.value *= Matrix4.diagonal3Values(zoomFactor, zoomFactor, 1);
  }

  void _transformationZoomOut() {
    controller.value *=
        Matrix4.diagonal3Values(1 / zoomFactor, 1 / zoomFactor, 1);
  }

  void _transformationMoveLeft() {
    controller.value *= Matrix4.translationValues(20, 0, 0);
  }

  void _transformationMoveRight() {
    controller.value *= Matrix4.translationValues(-20, 0, 0);
  }
}

enum ButtonLayout { vertical, horizontal }
