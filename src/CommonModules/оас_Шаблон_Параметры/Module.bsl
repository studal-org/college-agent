// @strict-types
#Область ПрограммныйИнтерфейс

// Генерировать определение параметров.
// 
// Параметры:
//  Путь - см. оас_Спецификация_1.PathItemObject
//  Операция - см. оас_Спецификация_1.OperationObject
// 
// Возвращаемое значение:
//  Структура:
//  	*ТекстФункцииОпределений - Строка
//  	*ТекстФункцииПараметров - Строка
Функция ГенерироватьОпределениеПараметровОперации(Путь, Операция) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("ТекстФункцииОпределений", "");
	Результат.Вставить("ТекстФункцииПараметров", "");
	
	ТекстОпределенияПараметров = "";

	Определения = Новый Соответствие;
	ИмяФункцииОпределений = "_Параметры_Определения";

	Параметры = УникальныеПараметрыОперации(Путь.parameters, Операция.parameters);
	Для Каждого Параметр Из Параметры Цикл
		Если Параметр.schema <> Неопределено Тогда
			Схема = Параметр.schema; // см. оас_Спецификация_1.SchemaObject
		ИначеЕсли Параметр.content <> Неопределено Тогда
			Content = Параметр.content; // см. оас_Спецификация_1.ParameterObject_Content
			//@skip-check dynamic-access-method-not-found
			КлючиContent = оас_Модуль.ом_Коллекция().СоответствиеКлючиМассив(Content); // Массив из Строка
			MimeТип = КлючиContent.Получить(0);
			Если MimeТип = Неопределено Тогда
				ВызватьИсключение "Невозможно определить схему параметра """ + Параметр.name + """ в " + Параметр.in;
			КонецЕсли;
			MediaType = Content.Получить(MimeТип);
			Если MediaType.schema = Неопределено Тогда
				ВызватьИсключение "Невозможно определить схему параметра """ + Параметр.name + """ в " + Параметр.in;
			КонецЕсли;
			Схема = MediaType.schema; // см. оас_Спецификация_1.SchemaObject
		Иначе
			ВызватьИсключение "Невозможно определить схему параметра """ + Параметр.name + """ в " + Параметр.in;
		КонецЕсли;
		ТипПараметра = оас_Схема.ГенераторТипаСхемы(Схема, Определения, ИмяФункцииОпределений + "." + Параметр.in + "_"
			+ Параметр.name);
		ТекстОпределенияПараметров = ТекстОпределенияПараметров + "*" + Параметр.name + " - "
			+ ТипПараметра + Символы.ПС;
	КонецЦикла;
	
	ТекстОпределенияПараметров = оас_Утилиты_КлиентСервер.СтрДобавитьОтступДляКаждойСтроки(
					ТекстОпределенияПараметров, "//" + Символы.Таб + Символы.Таб);

	ПараметрыФункцииОпределений = оас_Утилиты_КлиентСервер.ПараметрыОпределений(Определения, ИмяФункцииОпределений
		+ ".");

	ОпределенияПараметров = оас_Утилиты_КлиентСервер.СтрДобавитьОтступДляКаждойСтроки(
					ПараметрыФункцииОпределений.Определения, "//" + Символы.Таб);

	ТекстФункцииОпределений = ШаблонФункцииОпределений();

	ТекстФункцииОпределений = СтрЗаменить(ТекстФункцииОпределений, "{ОпределенияПараметров}", ОпределенияПараметров);
	ТекстФункцииОпределений = СтрЗаменить(ТекстФункцииОпределений, "{ИмяФункции}", ИмяФункцииОпределений);
	ТекстФункцииОпределений = СтрЗаменить(ТекстФункцииОпределений, "{Параметры}", ПараметрыФункцииОпределений.Параметры);

	ТекстФункцииПараметров = ШаблонФункцииПараметров();
	ТекстФункцииПараметров = СтрЗаменить(ТекстФункцииПараметров, "{ОпределенияПараметров}", ТекстОпределенияПараметров);

	Результат.ТекстФункцииОпределений = ТекстФункцииОпределений;
	Результат.ТекстФункцииПараметров = ТекстФункцииПараметров;

	Возврат Результат;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Шаблон функции параметров.
// 
// Возвращаемое значение:
//  Строка
Функция ШаблонФункцииПараметров()
	Таб = Символы.Таб;
	Результат =
	"// Параметры:
	|//{Таб}Параметры - Соответствие из КлючИЗначение -:
	|//{Таб}{Таб}*Ключ - Произвольный
	|//{Таб}{Таб}*Значение - Произвольный
	|// Возвращаемое значение:
	|//{Таб}Структура:
	|{ОпределенияПараметров}
	|Функция Параметры(Параметры)
	|{Таб}Результат = оас_Утилиты_КлиентСервер.ПолучитьСтруктуруИзСоответствия(Параметры);
	|{Таб}Возврат Результат;
	|КонецФункции";
	Результат = СтрЗаменить(Результат, "{Таб}", Таб);
	Возврат Результат;
КонецФункции

// Шаблон функции определений.
// 
// Возвращаемое значение:
//  Строка
Функция ШаблонФункцииОпределений()
	Таб = Символы.Таб;
	Результат =
	"//@skip-check module-unused-method
	|// Параметры:
	|{ОпределенияПараметров}
	|// Возвращаемое значение:
	|//{Таб}Неопределено
	|Функция {ИмяФункции}({Параметры})
	|{Таб}оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	|{Таб}Возврат Неопределено;
	|КонецФункции";
	Результат = СтрЗаменить(Результат, "{Таб}", Таб);
	Возврат Результат;
КонецФункции

// Уникальные параметры операции.
// 
// Параметры:
//  ПараметрыПути - Неопределено, Массив из см. оас_Спецификация_1.ParameterObject -
//  ПараметрыОперации - Неопределено, Массив из см. оас_Спецификация_1.ParameterObject -
// 
// Возвращаемое значение:
//  Массив из см. оас_Спецификация_1.ParameterObject
Функция УникальныеПараметрыОперации(ПараметрыПути, ПараметрыОперации)
	УникальныеПараметры = Новый Соответствие;
	//@skip-check dynamic-access-method-not-found
	Параметры = оас_Модуль.ом_Коллекция().МассивыОбъединить(
		?(ПараметрыПути <> Неопределено, ПараметрыПути, Новый Массив), ?(ПараметрыОперации <> Неопределено,
		ПараметрыОперации, Новый Массив)); // Массив из см. оас_Спецификация_1.ParameterObject
	Для Каждого Параметр Из Параметры Цикл
		Ключ = Новый Структура;
		Ключ.Вставить("name", Параметр.name);
		Ключ.Вставить("in", Параметр.in);
		УникальныеПараметры.Вставить(Ключ, Параметр);
	КонецЦикла;

	Результат = Новый Массив; // см. УникальныеПараметрыОперации
	Для Каждого Параметр Из УникальныеПараметры Цикл
		Результат.Добавить(Параметр.Значение);
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти