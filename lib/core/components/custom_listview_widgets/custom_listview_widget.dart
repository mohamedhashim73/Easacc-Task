import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import '../data_state_widgets/empty_view_widget.dart';
import '../data_state_widgets/loading_view_widget.dart';

class PaginatedListviewWidget extends StatelessWidget {
  final int? length;
  final bool? shimmerItemIsEnabled;
  final bool? shimmerListIsEnabled;
  final int? count;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Widget Function(int index) itemBuilder;
  final Widget shimmerWidget;
  final Widget? separatorWidget;
  const PaginatedListviewWidget({super.key,this.shimmerItemIsEnabled,this.count = 0, this.length = 0, this.scrollController, required this.itemBuilder, required this.shimmerWidget,this.physics, this.separatorWidget, this.shimmerListIsEnabled});

  @override
  Widget build(BuildContext context) {
    if( shimmerListIsEnabled == true ){
      return ShimmerListViewWidget(
          itemBuilder: (index)=> shimmerWidget
      );
    }
    else
      {
        return ListView.separated(
          itemCount: (length ?? 0) + 1,
          separatorBuilder: (context,index)=> separatorWidget ?? 0.vrSpace,
          shrinkWrap: true,
          physics: physics ?? const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          padding: context.listViewPadding,
          itemBuilder: (context,index) {
            if( index != length )
            {
              return itemBuilder(index);
            }
            else
            {
              if( shimmerItemIsEnabled == false || length == count )
              {
                return const SizedBox();
              }
              else
              {
                return shimmerWidget;
              }
            }
          },
        );
      }
  }
}

class PaginatedHorizontalSingleChildScrollWidget extends StatelessWidget {
  final int? length;
  final bool? shimmerItemIsEnabled;
  final bool? shimmerListIsEnabled;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Widget Function(int index) itemBuilder;
  final Widget shimmerWidget;
  final double? space;
  final EdgeInsets? padding;
  const PaginatedHorizontalSingleChildScrollWidget({super.key,this.shimmerItemIsEnabled, this.length = 0, this.scrollController, required this.itemBuilder, required this.shimmerWidget,this.physics, this.space, this.shimmerListIsEnabled, this.padding});

  @override
  Widget build(BuildContext context) {
    if( shimmerListIsEnabled == true ){
      return ShimmerListViewWidget(
          itemBuilder: (index)=> shimmerWidget
      );
    }
    else
      {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: physics,
          controller: scrollController,
          padding: padding ?? EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: space ?? 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate((length ?? 0) + 1, (index){
              if( index != length )
              {
                return itemBuilder(index);
              }
              else
              {
                if( shimmerItemIsEnabled == false )
                {
                  return const SizedBox();
                }
                else
                {
                  return shimmerWidget;
                }
              }
            }),
          ),
        );
      }
  }
}

class CustomListviewWidget extends StatelessWidget {
  final int? length;
  final int shimmerCount;
  final Axis? scrollDirection;
  final bool shimmerShownCondition;
  final bool isEmpty;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final String? emptyTxt;
  final double? emptyImageSize;
  final double? emptyTxtSize;
  final ScrollController? scrollController;
  final Widget Function(int index) itemBuilder;
  final Widget? shimmerWidget;
  final Widget? separatorWidget;
  final int? shownFirstItemAfterTimeAsMillSeconds;
  final EdgeInsets? paddingOnEmpty;
  const CustomListviewWidget({this.isEmpty = false,super.key,this.shimmerShownCondition = false, this.shimmerCount = 6, this.length = 0, this.scrollController, required this.itemBuilder,this.shimmerWidget, this.physics, this.scrollDirection, this.separatorWidget, this.padding, this.shownFirstItemAfterTimeAsMillSeconds, this.emptyTxt, this.emptyImageSize, this.emptyTxtSize, this.paddingOnEmpty});

  @override
  Widget build(BuildContext context) {
    if( isEmpty ){
      return Padding(
        padding: paddingOnEmpty ?? EdgeInsets.zero,
        child: EmptyViewWidget(
          title: emptyTxt,
        ),
      );
    }
    return ListView.separated(
      separatorBuilder: (context,index)=> separatorWidget ?? 0.vrSpace,
      itemCount: shimmerShownCondition ? shimmerCount : length!,
      shrinkWrap: true,
      scrollDirection: scrollDirection ?? Axis.vertical,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      padding: padding ?? EdgeInsets.zero,
      itemBuilder: (context,index) {
        if( !shimmerShownCondition )
        {
          return itemBuilder(index);
        }
        else
        {
          return shimmerWidget ?? const LoadingViewWidget();
        }
      },
    );
  }
}

class CustomHorizontalSingleChildScrollWidget extends StatelessWidget {
  final int? length;
  final Widget Function(int index) itemBuilder;
  final double space;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  const CustomHorizontalSingleChildScrollWidget({super.key,required this.length,required this.itemBuilder,this.space = 10, this.padding, this.physics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: physics,
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: space,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(length ?? 0, (index) => itemBuilder(index)),
      ),
    );
  }
}

class ShimmerListViewWidget extends StatelessWidget {
  final Widget Function(int index) itemBuilder;
  final Widget? separatorWidget;
  final ScrollPhysics? physics;
  final int count;
  final EdgeInsets? padding;
  const ShimmerListViewWidget({super.key,required this.itemBuilder,this.count = 4, this.separatorWidget, this.physics, this.padding});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: physics,
      padding: padding ?? EdgeInsets.zero,
      separatorBuilder: (context,index)=> separatorWidget ?? 0.vrSpace,
      itemCount: count,
      itemBuilder: (context,index)=> itemBuilder(index),
    );
  }
}