// BSLLS:CommonModuleInvalidType-off - тип модуля верен, может вызываться только в серверном контексте
// 
// Хранение спецификации OpenAPI
//  

#Область ПрограммныйИнтерфейс

// Возвращает правила текстом JSON
//
// Параметры: 
// 	Спецификация - Соответствие - Описание интерфейса внутренними объектами
//
// Возвращаемое значение: 
// 	Строка
//
// BSLLS:Typo-off - ложное срабатывание на сериализацию
Функция Сериализовать(Спецификация) Экспорт

	Настройки	= Новый НастройкиСериализацииJSON;
	Настройки.ФорматСериализацииДаты			= ФорматДатыJSON.ISO;
	Настройки.ВариантЗаписиДаты					= ВариантЗаписиДатыJSON.УниверсальнаяДата;
	Настройки.СериализовыватьМассивыКакОбъекты	= Ложь;
	
	Запись		= Новый ЗаписьJSON;
	Параметры	= Новый ПараметрыЗаписиJSON( , Символы.Таб);
	Запись.УстановитьСтроку(Параметры);
	ЗаписатьJSON(Запись
	, Спецификация
	, Настройки);
	
	Возврат Запись.Закрыть();
	
// BSLLS:Typo-on
КонецФункции // Сериализовать 

// Преобразование текста JSON внутренними объектами
//
// Параметры: 
// 	Текст - Строка - Правила формата JSON
//
// Возвращаемое значение: 
// 	Соответствие
//
// BSLLS:Typo-off - ложное срабатывание на сериализацию
Функция Десериализовать(Текст) Экспорт
	Чтение	= Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(Текст);
	// BSLLS:IncorrectLineBreak-off - ложное срабатывание
	Результат	= ПрочитатьJSON(Чтение
	, Истина
	, 
	, ФорматДатыJSON.ISO);
	// BSLLS:IncorrectLineBreak-on
	Чтение.Закрыть();
	
	Возврат Результат;
	
// BSLLS:Typo-on
КонецФункции // Десериализовать 

// Производит замену ссылок их значениями
//
// Параметры: 
// 	Спецификация - Соответствие - Правила внутренними объектами
//
// Возвращаемое значение: 
// 	Соответствие
//
Функция СсылкиРазыменовать(Спецификация) Экспорт
	
	Возврат СсылкиРазыменоватьОбход(Спецификация, Спецификация);
	
КонецФункции // СсылкиРазыменовать 

// Возвращает значение соответствия по ссылке
//
// Параметры: 
// 	Коллекция - Соответствие - Коллекция значений
// 	Ссылка - Строка - Адрес значения
//
// Возвращаемое значение: 
// 	Произвольный
//
Функция СсылкаЗначение(Коллекция, Ссылка) Экспорт
	
	Результат	= Неопределено;
	Путь		= оас_Модуль.ом_Строка().ВМассив(Ссылка, "/");
	
	Если Путь.Количество() И Путь[0] = "#" Тогда
		Источник	= Коллекция;
		Граница		= Путь.ВГраница() - 1;
		Для Индекс = 1 По Граница Цикл
			Источник	= Источник.Получить(Путь[Индекс]);
			Если НЕ оас_Модуль.ом_Значение().СоответствиеЭто(Источник) Тогда
				Источник	= Неопределено;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если оас_Модуль.ом_Значение().СоответствиеЭто(Источник) Тогда
			Результат	= Источник.Получить(Путь[Граница + 1]);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // СсылкаЗначение 

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Обход заполнения результата разыменования ссылок
//
// Параметры: 
// 	Источник - Соответствие - Обратабываемая ветка спецификации
// 	Спецификация - Соответствие - Исходная спецификация
//
// Возвращаемое значение: 
//
Функция СсылкиРазыменоватьОбход(Источник, Спецификация)
	
	Результат	= Новый Соответствие();
	
	// Если в источнике содержится ссылка, то
	// подменяем источник на значение
	Данные		= Источник;
	Ссылка		= Данные.Получить(СсылкаКлюч());
	Если Ссылка <> Неопределено Тогда
		Данные	= СсылкаЗначение(Спецификация, Ссылка);
		Если Данные = Неопределено Тогда
			Данные	= Источник;
		КонецЕсли;
	КонецЕсли;
	
	Для Каждого Элемент Из Данные Цикл
		Результат.Вставить(Элемент.Ключ, ЗначениеРазыменовать(Элемент.Значение, Спецификация));
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции // СсылкиРазыменоватьОбход 

// Возвращает разыменованное значение
//
// Параметры: 
// 	Значение - Произвольный - Разыменовываемое значение
// 	Спецификация - Соответствие - Спецификация
//
// Возвращаемое значение: 
// 	Произвольный
//
Функция ЗначениеРазыменовать(Значение, Спецификация)
	
	Результат	= Неопределено;
	
	Если оас_Модуль.ом_Значение().МассивЭто(Значение) Тогда
		Результат	= Новый Массив();
		Для Каждого Элемент Из Значение Цикл
			Результат.Добавить(ЗначениеРазыменовать(Элемент, Спецификация));
		КонецЦикла;
	Иначе
		Результат	= ?(оас_Модуль.ом_Значение().СоответствиеЭто(Значение)
		, СсылкиРазыменоватьОбход(Значение, Спецификация)
		, Значение);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // ЗначениеРазыменовать 

// Возвращает имя ключа ссылки
//
// Параметры: 
//
// Возвращаемое значение: 
// 	Строка
//
Функция СсылкаКлюч()
	
	Возврат "$ref";
	
КонецФункции // СсылкаКлюч 

#КонецОбласти

// BSLLS:CommonModuleInvalidType-on
