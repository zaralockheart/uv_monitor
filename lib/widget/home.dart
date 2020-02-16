import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uv_assessment/bloc/bloc.dart';
import 'package:uv_assessment/bloc/uv_monitor_state.dart';
import 'package:uv_assessment/res/color.dart';
import 'package:uv_assessment/utils/utils.dart';

/// Refer https://www.figma.com/file/TbdGiIl24TvsNqV3lIK9Dg/Assignment---Flutter?node-id=1%3A60
/// for design.
class Home extends HookWidget {
  final UvMonitorBloc bloc;

  const Home({this.bloc});

  static Future push(BuildContext context) => context.push(
        name: '/home',
        target: Home(
          bloc: UvMonitorBloc.init(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      bloc.add(Init());
      return null;
    }, [false]);

    return BlocProvider<UvMonitorBloc>(
      create: (_) => bloc,
      child: BlocListener<UvMonitorBloc, UvMonitorState>(
        condition: (prev, current) =>
            prev.uvFetchingState.error != current.uvFetchingState.error,
        listener: (blocContext, state) {
          if (state.uvFetchingState.error != null) {
            showDialog(
              context: blocContext,
              builder: (dialogContext) => AlertDialog(
                title: Text(context.locale.error),
                content: Text(state.uvFetchingState.error),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(context.locale.ok),
                  )
                ],
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: darkBrown,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TopScreen(),
              BottomScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
class TopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32.0),
          bottomRight: Radius.circular(32.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset('assets/shades.png'),
          Column(
            children: <Widget>[
              BlocBuilder<UvMonitorBloc, UvMonitorState>(
                condition: (prev, current) =>
                    prev.uvFetchingState.isFetchingData !=
                    current.uvFetchingState.isFetchingData,
                builder: (_, state) => Text(
                  state.uvFetchingState.isFetchingData
                      ? context.locale.fetching
                      : state.uvFetchingState.data?.result?.uvMax.toString(),
                  key: const Key('uv index'),
                  textAlign: TextAlign.center,
                  style: textTheme.headline3.copyWith(
                    fontSize: 64,
                    color: darkBlue,
                  ),
                ),
              ),
              Text(
                context.locale.uvIndex,
                textAlign: TextAlign.center,
                style: textTheme.headline3.copyWith(
                  fontSize: 36,
                  color: grey,
                ),
              ),
            ],
          ),
          BlocBuilder<UvMonitorBloc, UvMonitorState>(
            condition: (prev, current) =>
                prev.currentTime != current.currentTime,
            builder: (_, state) {
              final formattedCurrentTime = DateTime.now().reFormat();
              return Text(state?.currentTime ?? formattedCurrentTime,
                  key: const Key('time'),
                  textAlign: TextAlign.center,
                  style: textTheme.headline6.copyWith(
                    color: grey,
                    fontWeight: FontWeight.w300,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

@visibleForTesting
class BottomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleWhiteTheme = context.textTheme.headline6.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BlocBuilder<UvMonitorBloc, UvMonitorState>(
              builder: (_, state) => Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.all(20).copyWith(top: 41, bottom: 27),
                  child: MaterialButton(
                    disabledColor: Colors.green[100],
                    color: green,
                    onPressed: state.uvFetchingState.isFetchingData
                        ? null
                        : () =>
                            context.bloc<UvMonitorBloc>().add(FetchUvData()),
                    child: Text(
                      context.locale.refresh,
                      style: titleWhiteTheme,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20).copyWith(top: 41, bottom: 27),
                child: MaterialButton(
                  color: darkRed,
                  onPressed: () async {
                    await GoogleSignIn().signOut().then(print);

                    Navigator.pop(context);
                  },
                  child: Text(
                    context.locale.logout,
                    style: titleWhiteTheme,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<UvMonitorBloc, UvMonitorState>(
          condition: (prev, current) =>
              prev.latitude != current.latitude &&
              prev.longitude != current.longitude,
          builder: (_, state) {
            final noLocationDetected =
                state.latitude == null || state.latitude == null;
            if (noLocationDetected) {
              return Text(
                context.locale.noLocation,
                style: titleWhiteTheme,
              );
            }
            return Column(
              children: <Widget>[
                Text(
                  context.locale.latitude(state.latitude),
                  textAlign: TextAlign.center,
                  key: const Key('latitude'),
                  style: titleWhiteTheme,
                ),
                Text(
                  context.locale.longitude(state.longitude),
                  textAlign: TextAlign.center,
                  key: const Key('longitude'),
                  style: titleWhiteTheme,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
