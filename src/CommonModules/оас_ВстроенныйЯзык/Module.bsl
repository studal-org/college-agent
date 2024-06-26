// BSLLS:CommonModuleNameClientServer-off - без необходимости постфиксы не добавляем
// 
// Форматирование встроенного языка
//  

#Область ПрограммныйИнтерфейс

// Возвращает текст на встроенном языке форматированный HTML документом
//
// Параметры: 
// 	Текст - Строка - Исходный текст
// 	ЦветоваяСхема - Структура - Цветовая схема
//
// Возвращаемое значение: 
// 	Строка - Тело HTML документа
//
Функция ТекстВHTML(Текст, ЦветоваяСхема) Экспорт
	
	Результат	= "<div style=""background-color:" + ЦветоваяСхема.Фон + """><code><pre>";
	
	КлючевыеСлова	= КлючевыеСлова();
	СтрокиЧисло		= СтрЧислоСтрок(Текст);
	
	Для СтрокаНомер = 1 По СтрокиЧисло Цикл
		Результат	= Результат 
		+ СтрокаФорматировать(СтрПолучитьСтроку(Текст, СтрокаНомер), КлючевыеСлова, ЦветоваяСхема)
		+ Символы.ПС;
	КонецЦикла;
	
	Результат	= Результат + "</pre></code></div>";
	
	Возврат Результат;
	
КонецФункции // ТекстВHTML 

// Возвращает описание цветовой схемы. Цвета передаются 16ричными значениями вида AD7FA8
//
// Параметры: 
// 	КлючевоеСлово - Строка - Цвет ключевых слов
// 	Число - Строка - Цвет констант Число
// 	Строка - Строка - Цвет констант Строка
// 	Дата - Строка - Цвет констант Дата
// 	Идентификатор - Строка - Цвет идентификаторов
// 	Оператор - Строка - Цвет операторов
// 	Комментарий - Строка - Цвет комментариев
// 	Препроцессор - Строка - Цвет предпроцессора
// 	Прочее - Строка - Цвет прочего
// 	Фон - Строка - Цвет фона
//
// Возвращаемое значение: 
// 	ФиксированнаяСтруктура
//
// BSLLS:NumberOfParams-off - это нужные параметры
Функция ЦветоваяСхема(КлючевоеСлово
	, Число 
	, Строка
	, Дата
	, Идентификатор
	, Оператор
	, Комментарий
	, Препроцессор
	, Прочее
	, Фон) Экспорт
	// BSLLS:NumberOfParams-on
	
	Результат	= Новый Структура();
	Префикс		= "#";
	
	Результат.Вставить("КлючевоеСлово", Префикс + КлючевоеСлово);
	Результат.Вставить("Число", Префикс + Число);
	Результат.Вставить("Строка", Префикс + Строка);
	Результат.Вставить("Дата", Префикс + Дата);
	Результат.Вставить("Идентификатор", Префикс + Идентификатор);
	Результат.Вставить("Оператор", Префикс + Оператор);
	Результат.Вставить("Комментарий", Префикс + Комментарий);
	Результат.Вставить("Препроцессор", Префикс + Препроцессор);
	Результат.Вставить("Прочее", Префикс + Прочее);
	Результат.Вставить("Фон", Префикс + Фон);
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
	
КонецФункции // ЦветоваяСхема 

// Возвращает светлую цветовую схему
//
// Параметры: 
//
// Возвращаемое значение: 
// 	ФиксированнаяСтруктура
//
Функция ЦветоваяСхемаСветлая() Экспорт
	
	Возврат ЦветоваяСхема("D24C15"
	, "B68900"
	, "4CA49C"
	, "859900"
	, "258BD3"
	, "D42F33"
	, "93A1A1"
	, "D53584"
	, "899A33"
	, "FFFBF0");
	
КонецФункции // ЦветоваяСхемаСветлая 

// Возвращает стандартную цветовую схему
//
// Параметры: 
//
// Возвращаемое значение: 
// 	ФиксированнаяСтруктура
//
Функция ЦветоваяСхемаСтандартная() Экспорт
	
	Возврат ЦветоваяСхема("FF0000"
	, "000000"
	, "000000"
	, "000000"
	, "0000FF"
	, "FF0000"
	, "008000"
	, "963200"
	, "000000"
	, "FFFFFF");
	
КонецФункции // ЦветоваяСхемаСтандартная 

// Возвращает коллекцию ключевых слов встроенного языка
//
// Параметры: 
//
// Возвращаемое значение: 
// 	ФиксированноеСоответствие
//
Функция КлючевыеСлова() Экспорт
	
	Результат	= Новый Соответствие();
	
	// BSLLS:Typo-off - это индексы слов, ложное срабатывание
	Результат.Вставить("if", Истина);
	Результат.Вставить("если", Истина);
	Результат.Вставить("then", Истина);
	Результат.Вставить("тогда", Истина);
	Результат.Вставить("elsif", Истина);
	Результат.Вставить("иначеесли", Истина);
	Результат.Вставить("else", Истина);
	Результат.Вставить("иначе", Истина);
	Результат.Вставить("endif", Истина);
	Результат.Вставить("конецесли", Истина);
	Результат.Вставить("do", Истина);
	Результат.Вставить("цикл", Истина);
	Результат.Вставить("for", Истина);
	Результат.Вставить("для", Истина);
	Результат.Вставить("to", Истина);
	Результат.Вставить("по", Истина);
	Результат.Вставить("each", Истина);
	Результат.Вставить("каждого", Истина);
	Результат.Вставить("in", Истина);
	Результат.Вставить("из", Истина);
	Результат.Вставить("while", Истина);
	Результат.Вставить("пока", Истина);
	Результат.Вставить("enddo", Истина);
	Результат.Вставить("конеццикла", Истина);
	Результат.Вставить("procedure", Истина);
	Результат.Вставить("процедура", Истина);
	Результат.Вставить("endprocedure", Истина);
	Результат.Вставить("конецпроцедуры", Истина);
	Результат.Вставить("function", Истина);
	Результат.Вставить("функция", Истина);
	Результат.Вставить("endfunction", Истина);
	Результат.Вставить("конецфункции", Истина);
	Результат.Вставить("var", Истина);
	Результат.Вставить("перем", Истина);
	Результат.Вставить("export", Истина);
	Результат.Вставить("экспорт", Истина);
	Результат.Вставить("goto", Истина);
	Результат.Вставить("перейти", Истина);
	Результат.Вставить("and", Истина);
	Результат.Вставить("и", Истина);
	Результат.Вставить("or", Истина);
	Результат.Вставить("или", Истина);
	Результат.Вставить("not", Истина);
	Результат.Вставить("не", Истина);
	Результат.Вставить("val", Истина);
	Результат.Вставить("знач", Истина);
	Результат.Вставить("break", Истина);
	Результат.Вставить("прервать", Истина);
	Результат.Вставить("continue", Истина);
	Результат.Вставить("продолжить", Истина);
	Результат.Вставить("return", Истина);
	Результат.Вставить("возврат", Истина);
	Результат.Вставить("try", Истина);
	Результат.Вставить("попытка", Истина);
	Результат.Вставить("except", Истина);
	Результат.Вставить("исключение", Истина);
	Результат.Вставить("endtry", Истина);
	Результат.Вставить("конецпопытки", Истина);
	Результат.Вставить("raise", Истина);
	Результат.Вставить("вызватьисключение", Истина);
	Результат.Вставить("false", Истина);
	Результат.Вставить("ложь", Истина);
	Результат.Вставить("true", Истина);
	Результат.Вставить("истина", Истина);
	Результат.Вставить("undefined", Истина);
	Результат.Вставить("неопределено", Истина);
	Результат.Вставить("null", Истина);
	Результат.Вставить("new", Истина);
	Результат.Вставить("новый", Истина);
	Результат.Вставить("execute", Истина);
	Результат.Вставить("выполнить", Истина);
	// BSLLS:Typo-on
	
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции // КлючевыеСлова 

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает отформатированную строку
//
// Параметры: 
// 	Текст - Строка - Строка исходного текста
// 	КлючевыеСлова - ФиксированноеСоответствие - Ключевые слова языка
// 	ЦветоваяСхема - ФиксированнаяСтруктура - Используемая цветовая схема
//
// Возвращаемое значение: 
// 	Строка
//
Функция СтрокаФорматировать(Текст, КлючевыеСлова, ЦветоваяСхема)
	
	Результат	= "";
	ТекстСокрЛ	= СокрЛ(Текст);
	
	Если СтрокаПрепроцессорЭто(ТекстСокрЛ) Тогда
		Результат	= Результат + СтрокаHTML(Текст, ЦветоваяСхема.Препроцессор);
	ИначеЕсли СтрокаКомментарийЭто(ТекстСокрЛ) Тогда
		Результат	= Результат + СтрокаHTML(Текст, ЦветоваяСхема.Комментарий);
	Иначе
		// Пословный разбор
		ОбъектЭлементЭто	= Неопределено;
		ПредСлово			= Неопределено;
		Для Каждого Слово Из СловаМассив(Текст) Цикл
			// Точка может идти первой, это допустимый перенос
			ОбъектЭлементЭто	= (ОбъектЭлементЭто = Неопределено И Слово = ".") ИЛИ ПредСлово = ".";
			Результат			= Результат + СтрокаHTML(Слово
			, СловоЦвет(Слово, ОбъектЭлементЭто, КлючевыеСлова, ЦветоваяСхема));
			ПредСлово			= Слово;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // СтрокаФорматировать 

// Возвращает текст HTML строки текста
//
// Параметры: 
// 	Текст - Строка - Исходный текст
// 	Цвет - Строка - Цвет текста
//
// Возвращаемое значение: 
// 	Строка
//
Функция СтрокаHTML(Текст, Цвет)
	
	Возврат "<font color=""" + Цвет + """>" + Текст + "</font>";
	
КонецФункции // СтрокаHTML 

// Возвращает текст слова
//
// Параметры: 
// 	Слово - Строка - Текст слова
// 	ОбъектЭлементЭто - Булево - Слово входит в состав объекта
// 	КлючевыеСлова - Соответствие - Коллекция ключевых (предопределенных) слов языка
// 	ЦветоваяСхема - Структура - Используемая цветовая схема
//
// Возвращаемое значение: 
// 	Строка
//
Функция СловоЦвет(Слово, ОбъектЭлементЭто, КлючевыеСлова, ЦветоваяСхема)
	
	Результат	= ЦветоваяСхема.Идентификатор;
	
	Источник	= НРег(СокрЛП(Слово));
	Символ		= Лев(Источник, 1);
	
	Если СтрокаКомментарийЭто(Источник) Тогда
		Результат	= ЦветоваяСхема.Комментарий;
	ИначеЕсли СтрДлина(Источник) = 1 И СимволОператорЭто(Символ) Тогда
		Результат	= ЦветоваяСхема.Оператор;
	Иначе
		Если СимволКавычкаЭто(Символ) ИЛИ СимволСтрокаПереносЭто(Символ) Тогда
			Результат	= ЦветоваяСхема.Строка;
		ИначеЕсли оас_Модуль.ом_Строка().СимволЧислоЭто(Символ) Тогда
			Результат	= ЦветоваяСхема.Число;
		ИначеЕсли СимволКавычкаОдинарнаяЭто(Символ) Тогда
			Результат	= ЦветоваяСхема.Дата;
		ИначеЕсли НЕ ОбъектЭлементЭто И КлючевыеСлова.Получить(Источник) = Истина Тогда
			Результат	= ЦветоваяСхема.Оператор;
		Иначе
			Результат	= ЦветоваяСхема.Идентификатор;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // СловоЦвет 

// Возвращает массив слов
//
// Параметры: 
// 	Текст - Строка - Исходный текст
//
// Возвращаемое значение: 
// 	Массив
//
Функция СловаМассив(Текст)
	
	Результат	= Новый Массив();
	
	ТекстДлина				= СтрДлина(Текст);
	ПодстрокаЭто			= Ложь;
	ПодстрокаЗакрытиеЭто	= Ложь;
	СловаРазделители		= " ;+-/*=.,<>?""()[]{}!@#$^&№!|\";
	СловоНачало				= 1;
	
	Для Позиция = 1 По ТекстДлина Цикл
				
		Символ		= Сред(Текст, Позиция, 1);
		СледСимвол	= Сред(Текст, Позиция + 1, 1);
		
		// BSLLS:IfElseIfEndsWithElse-off - все верно, условие без блока Иначе
		Если НЕ ПодстрокаЭто И (СимволКавычкаЭто(Символ) ИЛИ СимволСтрокаПереносЭто(Символ)) Тогда
			ПодстрокаЭто			= Истина;
			ПодстрокаЗакрытиеЭто	= Ложь;
		ИначеЕсли НЕ ПодстрокаЭто И СтрокаКомментарийЭто(Символ + СледСимвол) Тогда
			// Остаток строки комментарий
			Результат.Добавить(Прав(Текст, СтрДлина(Текст) - Позиция + 1));
			Прервать;
		ИначеЕсли ПодстрокаЭто И СимволКавычкаЭто(Символ) Тогда
			Если СимволКавычкаЭто(СледСимвол) Тогда
				Позиция	= Позиция + 1;
				Продолжить;
			Иначе
				ПодстрокаЭто			= Ложь;
				ПодстрокаЗакрытиеЭто	= Истина;
			КонецЕсли;
		КонецЕсли;
		// BSLLS:IfElseIfEndsWithElse-on
		
		СловоМассивДобавить(Результат, Текст, ТекстДлина, Позиция, СловоНачало, ПодстрокаЭто, СловаРазделители);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции // СловаМассив 

// Добавляет слово в массив слов
//
// Параметры: 
// 	Результат - Массив - Заполняемый набор слов
// 	Текст - Строка - Исходный текст
// 	ТекстДлина - Число - Предварительно вычисленное СтрДлина(Текст)
// 	Позиция - Число - Текущая позиция разбора
// 	СловоНачало - Число - Начало текущего слова
// 	ПодстрокаЭто - Булево - Текущая позиция в подстроке
// 	СловаРазделители - Строка - Символы разделители слов
//
// BSLLS:CognitiveComplexity-off - вполне тривиальная конструкция
Процедура СловоМассивДобавить(Результат, Текст, ТекстДлина, Позиция, СловоНачало, ПодстрокаЭто, СловаРазделители)
	
	Если Позиция = ТекстДлина Тогда
		// Добавляем весь остаток
		Результат.Добавить(Сред(Текст, СловоНачало));
	Иначе
		Символ	= Сред(Текст, Позиция, 1);
		Если НЕ ПодстрокаЭто И РазделительСловЭто(КодСимвола(Символ), СловаРазделители) Тогда
			Если СимволОператорЭто(Символ) Тогда
				Результат.Добавить(Сред(Текст, СловоНачало, Позиция - СловоНачало));
				Результат.Добавить(Символ);
			ИначеЕсли СимволПробельныйЭто(Символ) И (Позиция - СловоНачало) = 1 Тогда
				// завершающие пробелы добавляем к предыдущему слову
				Граница	= Результат.ВГраница();
				Если Граница >= 0 Тогда
					Результат[Граница]	= Результат[Граница] + Символ;
				Иначе
					Результат.Добавить(Символ);
				КонецЕсли;
			Иначе
				Результат.Добавить(Сред(Текст, СловоНачало, Позиция - СловоНачало + 1));
			КонецЕсли;
			СловоНачало	= Позиция + 1;
		КонецЕсли;
	КонецЕсли;
	
// BSLLS:CognitiveComplexity-on
КонецПроцедуры // СловоМассивДобавить 

// Определяет, является ли символ разделителем.
//
// Параметры:
//  КодСимвола      - Число  - код проверяемого символа;
//  РазделителиСлов - Строка - символы разделителей. Если параметр не указан, то 
//                             разделителем считаются все символы, не являющиеся цифрами, 
//                             латинскими и кириллическими буквами, а также знаком подчеркивания.
//
// Возвращаемое значение:
//  Булево - Истина, если символ с кодом КодСимвола является разделителем.
//
Функция РазделительСловЭто(КодСимвола, РазделителиСлов = Неопределено) 
	
	Если РазделителиСлов <> Неопределено Тогда
		Возврат СтрНайти(РазделителиСлов, Символ(КодСимвола)) > 0;
	КонецЕсли;
		
	Диапазоны = Новый Массив;
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 48, 57)); 		// цифры
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 65, 90)); 		// латиница большие
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 97, 122)); 		// латиница маленькие
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 1040, 1103)); 	// кириллица
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 1025, 1025)); 	// символ "Ё"
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 1105, 1105)); 	// символ "ё"
	Диапазоны.Добавить(Новый Структура("Мин,Макс", 95, 95)); 		// символ "_"
	
	Для Каждого Диапазон Из Диапазоны Цикл
		Если КодСимвола >= Диапазон.Мин И КодСимвола <= Диапазон.Макс Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции // РазделительСловЭто

// Истина, если символ оператор
//
// Параметры: 
// 	Символ - Строка - Исследуемый символ
//
// Возвращаемое значение: 
// 	Булево
//
Функция СимволОператорЭто(Символ)
	
	Возврат СтрНайти("и?<>.,=()[];+-/*=.,", Символ) > 0;
	
КонецФункции // СимволОператорЭто 

// Истина, если символ кавычка
//
// Параметры: 
// 	Символ - Строка - Исследуемый символ
//
// Возвращаемое значение: 
// 	Булево
//
Функция СимволКавычкаЭто(Символ)
	
	Возврат Символ = """";
	
КонецФункции // СимволКавычкаЭто 

// Истина, если символ одинарная кавычка
//
// Параметры: 
// 	Символ - Строка - Исследуемый символ
//
// Возвращаемое значение: 
// 	Булево
//
Функция СимволКавычкаОдинарнаяЭто(Символ)
	
	Возврат Символ = "'";
	
КонецФункции // СимволКавычкаОдинарнаяЭто 

// Истина, если символ переноса многострочного текста
//
// Параметры: 
// 	Символ - Строка - Исследуемый символ
//
// Возвращаемое значение: 
// 	Булево
//
Функция СимволСтрокаПереносЭто(Символ)
	
	Возврат Символ = "|";
	
КонецФункции // СимволСтрокаПереносЭто 

// Истина, если символ пробельный
//
// Параметры: 
// 	Символ - Строка - Исследуемый символ
//
// Возвращаемое значение: 
// 	Булево
//
Функция СимволПробельныйЭто(Символ)
	
	// BSLLS:InvalidCharacterInFile-off - неразрывный пробел это верно
	Возврат СтрНайти(" " + " " + Символы.ВК + Символы.ВТаб + Символы.НПП + Символы.ПС + Символы.ПФ + Символы.Таб
	, Символ) > 0;
	// BSLLS:InvalidCharacterInFile-on
	
КонецФункции // СимволПробельныйЭто 

// Истина, если строка препроцессор
//
// Параметры: 
// 	Текст - Строка - Исследуемая строка
//
// Возвращаемое значение: 
// 	Булево
//
Функция СтрокаПрепроцессорЭто(Текст)
	
	Символ	= Лев(Текст, 1);
	
	Возврат Символ = "&" ИЛИ Символ = "#";
	
КонецФункции // СтрокаПрепроцессорЭто 

// Истина, если строка комментарий
//
// Параметры: 
// 	Текст - Строка - Исследуемая строка
//
// Возвращаемое значение: 
// 	Булево
//
Функция СтрокаКомментарийЭто(Текст)
	
	Возврат Лев(Текст, 2) = "//";
	
КонецФункции // СтрокаКомментарийЭто 

#КонецОбласти

// BSLLS:CommonModuleNameClientServer-on
