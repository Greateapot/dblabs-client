part of 'lab3_bloc.dart';

class Lab3SqlQueries {
  static const String databaseName = "`Vozovikov`";
  static const String tableName = "`Vozovikov`.`Table_Vozovikov`";

  static Future<void> createDatabase(ApiRepository apiRepository) async =>
      await apiRepository.createDatabase(databaseName: databaseName);

  static Future<void> dropDatabase(ApiRepository apiRepository) async =>
      await apiRepository.dropDatabase(databaseName: databaseName);

  static Future<void> createTable(ApiRepository apiRepository) async =>
      await apiRepository.createTable(
        tableName: tableName,
        options: [
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "id",
              dataType: DataType(
                type: DataTypeType.INT,
                intAttrs: IntDataTypeAttrs(unsigned: true, autoIncrement: true),
              ),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "last_name",
              dataType: DataType(
                type: DataTypeType.VARCHAR,
                stringAttrs: StringDataTypeAttrs(size: 30),
              ),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "first_name",
              dataType: DataType(
                type: DataTypeType.VARCHAR,
                stringAttrs: StringDataTypeAttrs(size: 20),
              ),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "patronymic",
              dataType: DataType(
                type: DataTypeType.VARCHAR,
                stringAttrs: StringDataTypeAttrs(size: 30),
              ),
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "phone_number",
              dataType: DataType(
                type: DataTypeType.VARCHAR,
                stringAttrs: StringDataTypeAttrs(size: 20),
              ),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "address",
              dataType: DataType(
                type: DataTypeType.VARCHAR,
                stringAttrs: StringDataTypeAttrs(size: 255),
              ),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "salary",
              dataType: DataType(
                  type: DataTypeType.INT,
                  intAttrs: IntDataTypeAttrs(unsigned: true)),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.COLUMN,
            column: Column(
              columnName: "work_duration",
              dataType: DataType(
                type: DataTypeType.INT,
              ),
              notNull: true,
            ),
          ),
          CreateTableOption(
            type: CreateTableOptionType.PRIMARY_KEY,
            primaryKey: PrimaryKey(keyParts: ["id"], constraintSymbol: "pk"),
          ),
        ],
      );

  static Future<void> dropTable(ApiRepository apiRepository) async =>
      await apiRepository.dropTable(tableName: tableName);

  static Future<Table> getEmployees(ApiRepository apiRepository) async =>
      await apiRepository.select(
        selectData: SelectData(
          tableName: tableName,
          columnNames: [
            "id",
            "last_name",
            "first_name",
            "patronymic",
            "phone_number",
            "address",
            "salary",
            "work_duration",
          ],
        ),
      );

  static Future<Table> getEmployeesPhoneNubersAndSalary(
    ApiRepository apiRepository,
  ) async =>
      await apiRepository.select(
        selectData: SelectData(
          tableName: tableName,
          columnNames: [
            "id",
            "last_name",
            "first_name",
            "patronymic",
            "phone_number",
            "salary",
          ],
        ),
      );

  static Future<Table> getEmployeesSortedByAddress(
    ApiRepository apiRepository,
  ) async =>
      await apiRepository.select(
        selectData: SelectData(
          tableName: tableName,
          columnNames: [
            "id",
            "last_name",
            "first_name",
            "patronymic",
            "address",
          ],
          orderBy: OrderBy(expr: "address"),
        ),
      );

  static Future<Table> getEmployeesFilteredByWorkDuration(
    ApiRepository apiRepository,
  ) async =>
      await apiRepository.select(
        selectData: SelectData(
          tableName: tableName,
          columnNames: [
            "id",
            "last_name",
            "first_name",
            "patronymic",
            "work_duration",
          ],
          whereCondition: "`work_duration` > 4",
        ),
      );

  static Future<void> fillTable(ApiRepository apiRepository) async =>
      await apiRepository.insert(
        tableName: tableName,
        insertType: InsertType.VALUES,
        columnNames: [
          "last_name",
          "first_name",
          "patronymic",
          "phone_number",
          "address",
          "salary",
          "work_duration",
        ],
        rowConstructorList: RowConstructorList(
          valueList: [
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Алексеев"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Александр"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Сергеевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (788) 412-32-81"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '61243'),
              Value(type: ValueType.VALUE_EXPR, expr: '7'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Арапов"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Матвей"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Владиславович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (430) 479-85-91"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '41924'),
              Value(type: ValueType.VALUE_EXPR, expr: '3'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Барыбин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Кирилл"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Юрьевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (181) 784-53-71"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '46756'),
              Value(type: ValueType.VALUE_EXPR, expr: '2'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Баяндин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Кирилл"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Семенович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (368) 573-21-91"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '52662'),
              Value(type: ValueType.VALUE_EXPR, expr: '2'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Бехтольт"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Дмитрий"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Андреевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (226) 080-49-34"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Пермь"'),
              Value(type: ValueType.VALUE_EXPR, expr: '53774'),
              Value(type: ValueType.VALUE_EXPR, expr: '7'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Бражкин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Егор"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Викторович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (499) 881-81-10"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '53572'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Будин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Данил"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Вячеславович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (644) 239-51-04"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '35005'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Вахрушева"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Арина"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Вячеславовна"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (252) 084-08-99"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '43041'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Вековшинин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Даниил"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Александрович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (255) 951-47-09"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '42046'),
              Value(type: ValueType.VALUE_EXPR, expr: '6'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Возовиков"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Юрий"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Артемьевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (530) 550-43-35"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Санкт-Петербург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '56848'),
              Value(type: ValueType.VALUE_EXPR, expr: '7'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Гарбуз"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Илья"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Игоревич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (229) 764-39-40"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '54660'),
              Value(type: ValueType.VALUE_EXPR, expr: '7'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Дудкин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Александр"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Васильевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (339) 427-15-20"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '61010'),
              Value(type: ValueType.VALUE_EXPR, expr: '7'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Зубов"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Ростислав"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Алексеевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (809) 710-51-99"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '36729'),
              Value(type: ValueType.VALUE_EXPR, expr: '2'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Искендеров"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Руслан"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Сахибович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (598) 370-52-78"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '49771'),
              Value(type: ValueType.VALUE_EXPR, expr: '8'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Максимов"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Александр"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Артемьевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (302) 298-90-79"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '41561'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Малых"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Владимир"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Олегович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (625) 906-52-97"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '46385'),
              Value(type: ValueType.VALUE_EXPR, expr: '6'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Молоков"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Андрей"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Максимович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (403) 976-20-02"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Пермь"'),
              Value(type: ValueType.VALUE_EXPR, expr: '41097'),
              Value(type: ValueType.VALUE_EXPR, expr: '3'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Мохов"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Максим"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Михайлович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (995) 370-97-47"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Пермь"'),
              Value(type: ValueType.VALUE_EXPR, expr: '62791'),
              Value(type: ValueType.VALUE_EXPR, expr: '8'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Петров"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Дмитрий"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Михайлович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (692) 976-70-46"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Санкт-Петербург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '51491'),
              Value(type: ValueType.VALUE_EXPR, expr: '8'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Прядеин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Иван"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Алексеевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (988) 033-34-91"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Пермь"'),
              Value(type: ValueType.VALUE_EXPR, expr: '34374'),
              Value(type: ValueType.VALUE_EXPR, expr: '8'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Радостев"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Илья"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Андреевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (830) 125-29-24"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '55762'),
              Value(type: ValueType.VALUE_EXPR, expr: '5'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Скорюпин"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Даниил"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Александрович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (326) 794-62-20"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '57601'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Третьяков"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Никита"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Александрович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (569) 345-67-12"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Екатеринбург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '66080'),
              Value(type: ValueType.VALUE_EXPR, expr: '3'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Хан"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Шахарияр"'),
              Value(type: ValueType.VALUE_DEFAULT),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (148) 791-37-72"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '53603'),
              Value(type: ValueType.VALUE_EXPR, expr: '7'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Мизёв"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Данил"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Юрьевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (740) 918-26-93"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '59389'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Ходжибоев"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Анушервон"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Бахтиёрович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (975) 080-17-55"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Санкт-Петербург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '40342'),
              Value(type: ValueType.VALUE_EXPR, expr: '8'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Хохряков"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Антон"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Сергеевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (528) 587-46-08"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Санкт-Петербург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '58214'),
              Value(type: ValueType.VALUE_EXPR, expr: '8'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Худеньких"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Валерий"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Дмитриевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (505) 742-47-82"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Санкт-Петербург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '30023'),
              Value(type: ValueType.VALUE_EXPR, expr: '2'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Чиртулов"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Матвей"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Вениаминович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (718) 775-10-43"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Пермь"'),
              Value(type: ValueType.VALUE_EXPR, expr: '30121'),
              Value(type: ValueType.VALUE_EXPR, expr: '2'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Шальнев"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Алексей"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Владиславович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (664) 363-60-12"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Санкт-Петербург"'),
              Value(type: ValueType.VALUE_EXPR, expr: '47499'),
              Value(type: ValueType.VALUE_EXPR, expr: '6'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Шараев"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Ростислав"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Алексеевич"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (616) 972-32-51"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Пермь"'),
              Value(type: ValueType.VALUE_EXPR, expr: '57853'),
              Value(type: ValueType.VALUE_EXPR, expr: '4'),
            ]),
            ValueList(values: [
              Value(type: ValueType.VALUE_EXPR, expr: '"Юсупов"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Тимур"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"Алмазович"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"+7 (387) 059-38-48"'),
              Value(type: ValueType.VALUE_EXPR, expr: '"г. Москва"'),
              Value(type: ValueType.VALUE_EXPR, expr: '50846'),
              Value(type: ValueType.VALUE_EXPR, expr: '6'),
            ]),
          ],
        ),
      );
}
