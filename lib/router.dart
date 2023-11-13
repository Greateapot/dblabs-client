import 'package:dblabs/dialogs/dialogs.dart';
import 'package:dblabs/pages/pages.dart';
import 'package:dblabs/shared/shared.dart';
import 'package:go_router/go_router.dart';

final subRoutes = [
  GoRoute(
    path: 'failed',
    pageBuilder: (context, state) => DialogPage(
      builder: (context) => FailedDialog(
        failureResponse: state.extra?.toString(),
      ),
    ),
  ),
  GoRoute(
    path: 'success',
    pageBuilder: (context, state) => DialogPage(
      builder: (context) => SuccessDialog(
        successResponse: state.extra?.toString(),
      ),
    ),
  ),
];

final editRoutes = [
  GoRoute(
    path: 'editColumn',
    pageBuilder: (context, state) => DialogPage(
      builder: (context) => EditColumnDialog(
        callback: (state.extra as Map<String, dynamic>)['callback'],
        column: (state.extra as Map<String, dynamic>)['column'],
      ),
    ),
  ),
  GoRoute(
    path: 'editSelectData',
    pageBuilder: (context, state) => DialogPage(
      builder: (context) => EditSelectDataDialog(
        callback: (state.extra as Map<String, dynamic>)['callback'],
        selectData: (state.extra as Map<String, dynamic>)['selectData'],
      ),
    ),
  ),
];

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
      routes: [
        ...subRoutes,
        ...editRoutes,
        GoRoute(
          path: 'showTables',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const ShowTablesDialog(),
          ),
        ),
        GoRoute(
          path: 'showTableStruct',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const ShowTableStructDialog(),
          ),
        ),
        GoRoute(
          path: 'createDatabase',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const CreateDatabaseDialog(),
          ),
        ),
        GoRoute(
          path: 'alterDatabase',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const AlterDatabaseDialog(),
          ),
        ),
        GoRoute(
          path: 'dropDatabase',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const DropDatabaseDialog(),
          ),
        ),
        GoRoute(
          path: 'createTable',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const CreateTableDialog(),
          ),
        ),
        GoRoute(
          path: 'alterTable',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const AlterTableDialog(),
          ),
        ),
        GoRoute(
          path: 'dropTable',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const DropTableDialog(),
          ),
        ),
        GoRoute(
          path: 'renameTable',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const RenameTableDialog(),
          ),
        ),
        GoRoute(
          path: 'truncateTable',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const TruncateTableDialog(),
          ),
        ),
        GoRoute(
          path: 'delete',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const DeleteDialog(),
          ),
        ),
        GoRoute(
          path: 'update',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const UpdateDialog(),
          ),
        ),
        GoRoute(
          path: 'join',
          routes: subRoutes + editRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const JoinDialog(),
          ),
        ),
        GoRoute(
          path: 'createTrigger',
          routes: subRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const CreateTriggerDialog(),
          ),
        ),
        GoRoute(
          path: 'dropTrigger',
          routes: subRoutes,
          pageBuilder: (context, state) => DialogPage(
            builder: (context) => const DropTriggerDialog(),
          ),
        ),
      ],
    ),
  ],
);
