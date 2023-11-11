import 'package:dblabs/dialogs/lab6/lab6.dart';
import 'package:dblabs/pages/lab6/lab6.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dblabs_api_repo/dblabs_api_repo.dart' as api;

class Lab6View extends StatelessWidget {
  const Lab6View({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: 60,
            child: ButtonsRow(
              buttonValues: [
                ButtonsRowElement(
                  label: "Удалить триггер",
                  onPressed: () => showActionDialog<String>(
                    context: context,
                    builder: (_) => DropTriggerDialog(),
                    onData: (data) => context
                        .read<Lab6Bloc>()
                        .add(Lab6DropTrigger(triggerName: data)),
                  ),
                ),
                ButtonsRowElement(
                  label: "Создать триггер",
                  onPressed: () => showActionDialog<
                      (
                        String,
                        api.TriggerTimeType,
                        api.TriggerEventType,
                        String,
                        api.TriggerOrderType?,
                        String?,
                        String,
                      )>(
                    context: context,
                    builder: (_) => const CreateTriggerDialog(),
                    onData: (data) =>
                        context.read<Lab6Bloc>().add(Lab6CreateTrigger(
                              triggerName: data.$1,
                              triggerTime: data.$2,
                              triggerEvent: data.$3,
                              tableName: data.$4,
                              triggerOrder: data.$5 != null
                                  ? api.TriggerOrder(
                                      type: data.$5,
                                      otherTriggerName: data.$6,
                                    )
                                  : null,
                              triggerBody: data.$7,
                            )),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: LabsBlocBuilder<Lab6Bloc>()),
        ],
      );
}
