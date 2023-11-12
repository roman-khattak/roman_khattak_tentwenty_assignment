import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  MovieListItem({Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  final GlobalKey backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: AspectRatio(    // Aspect ratio is used to define the size of the container in terms of Vertical by Horizontal ratio (Used for Responsiveness)
          aspectRatio: 16 / 9,
        child: ClipRRect(    // wrap the stack with 'ClipRRect' so that we can add borderRadius around each widget
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(  //we use stack so that we can overlay more widgets over one-another
            children: [
              ///In Flutter, 'Flow' is a widget that provides a way to implement custom layout algorithms that are not possible or easy to achieve with the built-in layout widgets such as Row, Column, Stack, and Flex.
              /// The 'Flow' widget is useful for creating custom layouts that require complex positioning or animation effects, such as staggered grids, circular layouts, or parallax scrolling effects.
              /// It allows you to create layouts that are not constrained by the limitations of the built-in layout widgets and gives you full control over the positioning and layout of the child widgets.
              Flow(
                delegate: _ParallaxFlowDelegate(
                    scrollable: Scrollable.of(context),
                    listItemContext: context,
                    backgroundImageKey: backgroundImageKey
                ),
                children: [
                  Image.network(
                    "https://image.tmdb.org/t/p/w500${imageUrl}",
                  width: double.infinity,  // with this image will take the full width of the screen avilable to it
                  key: backgroundImageKey,    // assigning unique globalkey to each of the widget
                  fit: BoxFit.cover,
                ),
                ]
              ),

              // This can be useful if you want the image to be the background of the entire screen and you don't have any other widgets that need to be positioned above it.
              //
              // However, if you have other widgets in the Stack that need to be positioned above the image, then you may not want to use Positioned.fill. Instead, you can use the width and height properties of the SvgPicture widget to specify the desired size of the image.
              Positioned.fill(   // ' Positioned.fill' is used to add a LinearGradient on top of the Image so that we create a darker part in the bottom part of the image so that we can overlay some "White Text over it" and be able to see it clearly
                 //'Positioned.fill' widget is used to fill the entire space of its parent widge
                 // here it is used to fill the entire space of the Image widget that it is being positioned on top of.
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7)   // this means that the color visibility will be 70%
                            ],
                          // we add 'begin' and 'end' parameters inside linearGradient to define that Linear Gradient started in the upper part of the image and finished in the bottom part
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,

                          stops: [0.6, 0.95]    // then we add the 'stops' so that we have a darker area only in the bottom part of the image

                                             /// ... ... Explaining stops property:  stops: [0.6, 0.95] ... ... ///
                          // In this case, the gradient has two stops: 0.6 and 0.95. The first stop, 0.6, means that the first color in the colors array (transparent) will be visible until 60% of the way down the image.
                          // At this point, the gradient will begin to transition to the second color in the array (black with an opacity of 0.7).
                         // The second stop, 0.95, means that the gradient will reach its darkest point at 95% of the way down the image.
                          // This means that the darker area of the gradient will start at 60% of the way down the image and gradually become darker until it reaches its darkest point at 95% of the way down the image.
                          // After this point, the gradient will transition back to being transparent, so that the top part of the image is not affected by the gradient.
                       // Overall, the stops property allows you to create more complex gradients that have smooth transitions between different colors, which can be used to create interesting visual effects on your UI elements.

                        )
                      )
                  )
              ),
              Positioned(
                // to set the column at the Left-Bottom part of each card
                left: 20,
                bottom: 20,
                child: Column( // now we add a column widget so that we can add a few text widgets at the bottom part of the image for displaying information regarding video

                  ///The mainAxisSize property is used to control the amount of space that a widget occupies along the main axis of its parent.
                  ///In Flutter, the main axis is typically the vertical axis for a Column widget and the horizontal axis for a Row widget.
              ///  The MainAxisSize.min value means that the widget should occupy the minimum amount of space necessary to contain its children along the main axis.
                  ///  This can be useful when you want to make a widget as small as possible, for example, when you want to put multiple widgets side-by-side or top-to-bottom and you don't want any unnecessary space between them.
                  mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )),
                ],
                ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}

//A scrolling parallax effect in Flutter is a visual effect that creates an illusion of depth and motion by moving multiple layers of content at different speeds as the user scrolls.
// The term "parallax" refers to the apparent displacement or difference in position of objects viewed from different angles.
//It adds a sense of depth to the design of UI

class _ParallaxFlowDelegate extends FlowDelegate{

  final ScrollableState scrollable; // we will use use it to retrieve all the information about the scrolling list that includes all the Movie cards
  final BuildContext listItemContext;    // 'context' of each of the movie card in the list ie; through this we get bounds or area occupied by each of the movie Card in the list
  final GlobalKey backgroundImageKey;    // we have already assigned it to each of the background image

  _ParallaxFlowDelegate({              // making constructor of this custom class while making all the parameters required
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);   // we also need to add the superClass here because the ParalaxFlowDelegate will repaint when the input changes however it doesnot change when the scroll position of the list changes
  //By setting repaint to scrollable.position, we are telling Flutter to 'repaint' the widget whenever the scroll position of the 'scrollableState' object changes.

  //In Flutter, 'BoxConstraints' is a class that describes the minimum and maximum height and width that a widget can have. The 'getConstraintsForChild' method is an overridden method of the 'FlowDelegate' class, and it is used to define the size constraints for each child widget in the 'Flow'.
 //In the code you provided, 'getConstraintsForChild' is used to set the width of the background image of the movie card to the maximum width allowed by the 'Flow' widget.
 //In this case, the 'width' parameter of the tightFor constructor is set to 'constraints.maxWidth', which means that the background image will be as wide as the maximum width allowed by the 'Flow' widget.

  ///In Flutter, 'Flow' is a widget that provides a way to implement custom layout algorithms that are not possible or easy to achieve with the built-in layout widgets such as Row, Column, Stack, and Flex.
  /// The 'Flow' widget is useful for creating custom layouts that require complex positioning or animation effects, such as staggered grids, circular layouts, or parallax scrolling effects. It allows you to create layouts that are not constrained by the limitations of the built-in layout widgets and gives you full control over the positioning and layout of the child widgets.
  @override
   BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {  //this method will define the width of the background image of the Movie Card
   return BoxConstraints.tightFor(width: constraints.maxWidth);
   }

  @override
  void paintChildren(FlowPaintingContext context) {
    // first implement the layout calculation for the parallax effect
    //so we will calculate the pixel position within the viewPort of the specific movie card
    // So we donot look only at the widget tree but also need to access data from the render Tree so first we will use the 'find render object method' inside the context of 'scrollable state widget' and this will help us save two dimension coordinate system
    // and each of these point is located inside the 'viewport' and the coordinate depend on the actual height and width of the scrollable area so the 'upper Left corner' will have coordinates (0,0) while 'bottom right corner' will be equal to 'width' and 'height'.
final scrollabeBox = scrollable.context.findRenderObject() as RenderBox;
    //Now we save another 'render box into the 'list item box variable'. This include all the coordinates of the movie card that we are looking at.
final listItemBox =  listItemContext.findRenderObject() as RenderBox;
    // finally we will compare the coordinate of the movie card saved inside the 'listItemBox variable' with the coordinate of its ancestor so we use the "scrollable Box" variable
   //   //and now again we will get the coordinates of the list item so the movie card relatively to the scrolling area
final listItemOffset = listItemBox.localToGlobal(
  listItemBox.size.centerLeft(Offset.zero),
  ancestor: scrollabeBox
);

///  ... Note :
    ///  1. the viewport is the visible portion of a widget that is currently displayed on the screen.
    ///  2. The viewport is defined by the size and position of the widget that contains it, which is usually a 'ScrollView' or one of its subclasses such as 'ListView', 'GridView', 'SingleChildScrollView', etc.
    ///  3. The viewport is responsible for scrolling the content within its boundaries, allowing the user to view more or less of the content as they interact with the app.

/// ... Now calculating 'percentage position for the list item within the scrollable are

// if you look at the up-Right part of screen so the card you see is 'Hustle', it has a value of Zero percent because it is aligning in the upper part of the scrollable area,
// While the card that you will see at the bottom of thte list will have a value of 100 percent because it is at the bottom of the scrollable area so to do so first we save the 'viewPort' dimensions inside the 'viewportDimension variable' and this comes from the scrollable state
  // we also take the 'listItemOffset variable' and use it together with 'viewportDimenstion' variable to calculate the percentage position

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollableFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0); // assigning lower and upper limits

    /// ...Calculate the vertical alignment of the background based on the scroll percentage
 // for that we use the percentage position to align the Movie cards on the screen so if again the percentage position is zero then we should use alignment 0 and -1 otherwise if it is 100% so we should use alignment 0 and 1. And basically these coordinates corresponds to the top and bottom alignment respectively
    final verticalAlignment = Alignment(0.0, scrollableFraction * 2 - 1);

/// ... Now that we got the value of 'verticalAlignment'so we shall convert the background alignment into a pixel offset so that we are able to 'Paint' widget on the screen
 // so for that first we take the image size by looking at the render box that we can find using GlobalKey of the background image
final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;

    //then we take size of the list item and we save it again in the 'listItemSize' variable
final listItemSize = context.size;

    //finally we use these two variables we just created and we also use the 'verticalAlignment' variable and we create a rectangle that define where we have to position the background image on the screen.
    //so for that we use verticalAlignement.inscribe and we pass the " background Size and ListItemSize "
  final childRect = verticalAlignment.inscribe(
      backgroundSize,
      Offset.zero & listItemSize,
  );

  /// ... Here is Last step to complete the parallax effect is to Paint the background
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, childRect.top)).transform,  // we translate the image here and this is what creates and returns the parallax effect
    );
  }

  // customizing the 'shouldRepaint' function
  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {  // Here we shall pass our CustomFlowDeleate otherwise we get error
    return scrollable != oldDelegate.scrollable ||          // return scrollable not equal to the previous version of the scrollable
    listItemContext != oldDelegate.listItemContext ||      // repaint is the 'listItemContext' is different from previous value of the 'listItemContext'
   backgroundImageKey != oldDelegate.backgroundImageKey;   //repaint it if the image is different
  }

}