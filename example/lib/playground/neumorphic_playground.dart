import 'package:example/lib/color_selector.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicPlayground extends StatefulWidget {
  const NeumorphicPlayground({super.key});

  @override
  NeumorphicPlaygroundState createState() => NeumorphicPlaygroundState();
}

class NeumorphicPlaygroundState extends State<NeumorphicPlayground> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

class __PageState extends State<_Page> {
  LightSource lightSource = LightSource.topLeft;
  NeumorphicShape shape = NeumorphicShape.flat;
  NeumorphicBoxShape? boxShape;
  double depth = 5;
  double intensity = 0.5;
  double surfaceIntensity = 0.5;
  double cornerRadius = 20;
  double height = 150.0;
  double width = 150.0;

  static const minWidth = 50.0;
  static const maxWidth = 200.0;
  static const minHeight = 50.0;
  static const maxHeight = 200.0;

  bool? haveNeumorphicChild = false;
  bool? childOppositeLightsourceChild = false;
  bool? drawAboveChild = false;
  double childMargin = 5;
  double childDepth = 5;

  @override
  void initState() {
    boxShape = NeumorphicBoxShape.path(NeumorphicFlutterLogoPathProvider());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        //appBar: NeumorphicAppBar(
        //  title: Text('Playground'),
        //),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text(
                  "back",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  lightSourceWidgets(),
                  Center(child: neumorphic()),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: _configurators(),
            )
          ],
        ));
  }

  int selectedConfiguratorIndex = 0;

  Widget _configurators() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    const Color buttonInnactiveColor = Colors.white;

    const Color textActiveColor = Colors.white;
    final Color textInactiveColor = Colors.black.withOpacity(0.3);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: selectedConfiguratorIndex == 0
                          ? buttonActiveColor
                          : buttonInnactiveColor,
                    ),
                    child: Text(
                      "Style",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 0
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 0;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: selectedConfiguratorIndex == 1
                          ? buttonActiveColor
                          : buttonInnactiveColor,
                    ),
                    child: Text(
                      "Element",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 1
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 1;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: selectedConfiguratorIndex == 2
                          ? buttonActiveColor
                          : buttonInnactiveColor,
                    ),
                    child: Text(
                      "Child",
                      style: TextStyle(
                        color: selectedConfiguratorIndex == 2
                            ? textActiveColor
                            : textInactiveColor,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedConfiguratorIndex = 2;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          _configuratorsChild(),
        ],
      ),
    );
  }

  Widget _configuratorsChild() {
    switch (selectedConfiguratorIndex) {
      case 0:
        return styleCustomizer();

      case 1:
        return elementCustomizer();

      case 2:
        return childCustomizer();
    }
    return const SizedBox();
  }

  Widget styleCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        depthSelector(),
        intensitySelector(),
        surfaceIntensitySelector(),
        colorPicker(),
      ],
    );
  }

  Widget elementCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        boxshapeWidget(),
        cornerRadiusSelector(),
        shapeWidget(),
        sizeSelector(),
      ],
    );
  }

  Widget childCustomizer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        hasChildSelector(),
        drawAboveChildSelector(),
        childDepthSelector(),
        childMarginSelector(),
        childOppositeLightsourceSelector(),
      ],
    );
  }

  Widget colorPicker() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 12,
        ),
        const Text("Color "),
        const SizedBox(
          width: 4,
        ),
        ColorSelector(
          onColorChanged: (color) {
            setState(() {
              NeumorphicTheme.of(context)!
                  .updateCurrentTheme(NeumorphicThemeData(baseColor: color));
            });
          },
          color: NeumorphicTheme.baseColor(context),
        ),
      ],
    );
  }

  Widget neumorphic() {
    return NeumorphicButton(
      padding: EdgeInsets.zero,
      duration: const Duration(milliseconds: 300),
      onPressed: () {
        setState(() {});
      },
      drawSurfaceAboveChild: drawAboveChild!,
      style: NeumorphicStyle(
        boxShape: boxShape,
        //border: NeumorphicBorder(),
        shape: shape,
        intensity: intensity,
        /*
        shadowLightColor: Colors.red,
        shadowDarkColor: Colors.blue,
        shadowLightColorEmboss: Colors.red,
        shadowDarkColorEmboss: Colors.blue,
         */
        surfaceIntensity: surfaceIntensity,
        depth: depth,
        lightSource: lightSource,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: haveNeumorphicChild!
            ? neumorphicChild()
            : const Center(child: Text("")),
      ),
    );
  }

  Widget neumorphicChild() {
    return Neumorphic(
      padding: EdgeInsets.zero,
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.all(childMargin),
      drawSurfaceAboveChild: true,
      style: NeumorphicStyle(
          boxShape: boxShape,
          //shape: this.shape,
          intensity: intensity,
          surfaceIntensity: surfaceIntensity,
          depth: childDepth,
          lightSource: lightSource,
          oppositeShadowLightSource: childOppositeLightsourceChild!),
      child: const SizedBox.expand(),
    );
  }

  Widget depthSelector() {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Depth"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_DEPTH,
            max: Neumorphic.MAX_DEPTH,
            value: depth,
            onChanged: (value) {
              setState(() {
                depth = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(depth.floor().toString()),
        ),
      ],
    );
  }

  Widget childDepthSelector() {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Depth"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_DEPTH,
            max: Neumorphic.MAX_DEPTH,
            value: childDepth,
            onChanged: (value) {
              setState(() {
                childDepth = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(childDepth.floor().toString()),
        ),
      ],
    );
  }

  Widget childMarginSelector() {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Child Margin"),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 40,
            value: childMargin,
            onChanged: (value) {
              setState(() {
                childMargin = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(childMargin.floor().toString()),
        ),
      ],
    );
  }

  Widget hasChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Has Child"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: haveNeumorphicChild,
            onChanged: (value) {
              setState(() {
                haveNeumorphicChild = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget drawAboveChildSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Draw above child"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: drawAboveChild,
            onChanged: (value) {
              setState(() {
                drawAboveChild = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget childOppositeLightsourceSelector() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("OppositeLight"),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Checkbox(
            value: childOppositeLightsourceChild,
            onChanged: (value) {
              setState(() {
                childOppositeLightsourceChild = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget sizeSelector() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 12,
        ),
        const Text("W: "),
        Expanded(
          child: Slider(
            min: minWidth,
            max: maxWidth,
            value: width,
            onChanged: (value) {
              setState(() {
                width = value;
              });
            },
          ),
        ),
        const Text("H: "),
        Expanded(
          child: Slider(
            min: minHeight,
            max: maxHeight,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget cornerRadiusSelector() {
    if (boxShape!.isRoundRect || boxShape!.isBeveled) {
      return Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("Corner"),
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: 30,
              value: cornerRadius,
              onChanged: (value) {
                setState(() {
                  cornerRadius = value;
                  if (boxShape!.isRoundRect) {
                    boxShape = NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(cornerRadius));
                  }
                  if (boxShape!.isBeveled) {
                    boxShape = NeumorphicBoxShape.beveled(
                        BorderRadius.circular(cornerRadius));
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(cornerRadius.floor().toString()),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget intensitySelector() {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("Intensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_INTENSITY, //in case of != 0
            max: Neumorphic.MAX_INTENSITY,
            value: intensity,
            onChanged: (value) {
              setState(() {
                intensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(((intensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget surfaceIntensitySelector() {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Text("SurfaceIntensity"),
        ),
        Expanded(
          child: Slider(
            min: Neumorphic.MIN_INTENSITY, //in case of != 0
            max: Neumorphic.MAX_INTENSITY,
            value: surfaceIntensity,
            onChanged: (value) {
              setState(() {
                surfaceIntensity = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(((surfaceIntensity * 100).floor() / 100).toString()),
        ),
      ],
    );
  }

  Widget boxshapeWidget() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    const Color buttonInnactiveColor = Colors.white;

    const Color textActiveColor = Colors.white;
    final Color textInactiveColor = Colors.black.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: boxShape!.isRoundRect
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  boxShape = NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(cornerRadius));
                });
              },
              child: Text(
                "Rect",
                style: TextStyle(
                    color: boxShape!.isRoundRect
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: boxShape!.isBeveled
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  boxShape = NeumorphicBoxShape.beveled(
                      BorderRadius.circular(cornerRadius));
                });
              },
              child: Text(
                "Beveled",
                style: TextStyle(
                    color: boxShape!.isBeveled
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: boxShape!.isCircle
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  boxShape = const NeumorphicBoxShape.circle();
                });
              },
              child: Text(
                "Circle",
                style: TextStyle(
                    color: boxShape!.isCircle
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: boxShape!.isStadium
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  boxShape = const NeumorphicBoxShape.stadium();
                });
              },
              child: Text(
                "Stadium",
                style: TextStyle(
                    color: boxShape!.isStadium
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: boxShape!.isCustomPath
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  boxShape = NeumorphicBoxShape.path(
                      NeumorphicFlutterLogoPathProvider());
                });
              },
              child: Text(
                "Custom",
                style: TextStyle(
                    color: boxShape!.isCustomPath
                        ? textActiveColor
                        : textInactiveColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget shapeWidget() {
    final Color buttonActiveColor = Theme.of(context).colorScheme.secondary;
    const Color buttonInnactiveColor = Colors.white;

    const Color iconActiveColor = Colors.white;
    final Color iconInactiveColor = Colors.black.withOpacity(0.3);

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: shape == NeumorphicShape.concave
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.concave;
                });
              },
              child: Image.asset("assets/images/concave.png",
                  color: shape == NeumorphicShape.concave
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: shape == NeumorphicShape.convex
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.convex;
                });
              },
              child: Image.asset("assets/images/convex.png",
                  color: shape == NeumorphicShape.convex
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: shape == NeumorphicShape.flat
                    ? buttonActiveColor
                    : buttonInnactiveColor,
              ),
              onPressed: () {
                setState(() {
                  shape = NeumorphicShape.flat;
                });
              },
              child: Image.asset("assets/images/flat.png",
                  color: shape == NeumorphicShape.flat
                      ? iconActiveColor
                      : iconInactiveColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget lightSourceWidgets() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 10,
          right: 10,
          child: Slider(
            min: -1,
            max: 1,
            value: lightSource.dx,
            onChanged: (value) {
              setState(() {
                lightSource = lightSource.copyWith(dx: value);
              });
            },
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          bottom: 10,
          child: RotatedBox(
            quarterTurns: 1,
            child: Slider(
              min: -1,
              max: 1,
              value: lightSource.dy,
              onChanged: (value) {
                setState(() {
                  lightSource = lightSource.copyWith(dy: value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
