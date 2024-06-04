// BSLLS:CommonModuleInvalidType-off - тип модуля верен, может вызываться только в серверном контексте
// 
// Обработка конечных точек сервиса
//  

#Область ПрограммныйИнтерфейс

// Возвращает идентификатор точки в настройках
//
// Параметры: 
// 	Ресурс - Строка - Ключ точки
// 	Метод - Строка - Имя HTTP метода
//
// Возвращаемое значение: 
// 	Строка
//
Функция Идентификатор(Ресурс, Метод) Экспорт
	
	Возврат Метод + "#" + Ресурс;
	
КонецФункции // Идентификатор 

// Истина, если путь ресурса содержит параметры
//
// Параметры: 
// 	Ресурс - Строка - Адрес ресурса
//
// Возвращаемое значение: 
// 	Булево
//
Функция ПутьПараметризован(Ресурс) Экспорт
	
	Возврат СтрНайти(Ресурс, "{") <> 0;
	
КонецФункции // ПутьПараметризован 

// Возвращает индексы параметров содержащихся в пути
//
// Параметры: 
// 	Ресурс - Строка - Ресурс
//
// Возвращаемое значение: 
// 	ФиксированноеСоответствие
//
Функция ПутьПараметрыИндексы(Ресурс) Экспорт
	
	Результат	= Новый Соответствие();
	
	Начало		= "{";
	Окончание	= "}";
	
	// BSLLS:MagicNumber-off - вполне просто
	Если ПутьПараметризован(Ресурс) Тогда
		// Ресурсы идут с ведущим слешем. Избавляемся от ведущего пустого элеемнта
		Части	= оас_Модуль.ом_Строка().ВМассив(Сред(Ресурс, 2), "/");
		Граница	= Части.ВГраница();
		Для Индекс = 0 По Граница Цикл
			Элемент	= Части[Индекс];
			Если Лев(Элемент, 1) = Начало И Прав(Элемент, 1) = Окончание Тогда
				Результат.Вставить(Сред(Элемент, 2, СтрДлина(Элемент) - 2), Индекс);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	// BSLLS:MagicNumber-on
	
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции // ПутьПараметрыИндексы 

// Возвращает шаблон поиска параметризованной точки
//
// Параметры: 
// 	Ресурс - Строка - Идентификатор по спецификации
// 	Параметры - Соответствие - Параметры точки
//
// Возвращаемое значение: 
// 	Строка
//
Функция Шаблон(Ресурс, Параметры) Экспорт
	
	Результат	= "";
	Остаток		= Ресурс;
	
	Разделитель			= "/";
	ШаблонЧисло			= "([\d^/])+";
	ШаблонСтрока		= "([\S^/])+";
	Начало				= "\S{0}";
	
	Части	= оас_Модуль.ом_Строка().ВМассив(Ресурс, Разделитель);
	Граница	= Части.ВГраница();
	
	Для Смещение = 0 По Граница Цикл
		Если Смещение = Граница Тогда
			// Первый элемент не обрабатываем - там путое значение от лидирующего разделителя
			Прервать;
		КонецЕсли;
		ОкончаниеЭто	= (Смещение = 0);
		Часть			= Части[Граница - Смещение];
		ПараметрИмя		= РесурсЧастьПараметрИмя(Часть);
		Если ПараметрИмя = Неопределено Тогда
			Результат	= Разделитель + Часть + Результат;
		Иначе
			Результат	= ПараметрШаблон(Ресурс
			, ПараметрИмя
			, Параметры.Получить(ПараметрИмя)
			, Разделитель
			, ШаблонЧисло
			, ШаблонСтрока) + Результат;
		КонецЕсли;
	КонецЦикла;
	
	Результат	= Начало + Результат;
	
	Возврат Результат;
	
КонецФункции // Шаблон 

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает шаблон параметра
//
// Параметры: 
// 	Ресурс - Строка - Имя ресурса владельца параметра
// 	Имя - Строка - Имя параметра
// 	Правила - Соответствие - Правила параметра
// 	Разделитель - Строка - Разделитель параметра и других частей адреса
// 	ШаблонЧисло - Строка - Шаблон числового параметра
// 	ШаблонСтрока - Строка - Шаблон строкового параметра
//
// Возвращаемое значение: 
// 	Строка
//
Функция ПараметрШаблон(Ресурс, Имя, Правила, Разделитель, ШаблонЧисло, ШаблонСтрока)
	
	Результат	= Неопределено;
	
	Если Правила = Неопределено Тогда
		ВызватьИсключение НСтр("ru = 'Не описан параметр " + Имя + " Ресурс " + Ресурс + "'");
	ИначеЕсли НЕ оас_ПараметрРазмещение.РесурсЭто(оас_Параметр.Размещение(Правила)) Тогда
		ВызватьИсключение НСтр("ru = 'Неверное размещение параметра " + Имя + " ресурса " + Ресурс + "'");
	Иначе
		Результат		= Разделитель + ?(оас_Параметр.ЧислоЭто(Правила), ШаблонЧисло, ШаблонСтрока) + Результат;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // ПараметрШаблон 

// Возвращает имя параметра части ресурса
//
// Параметры: 
// 	Источник - Строка - Часть ресурса
//
// Возвращаемое значение: 
// 	Строка, Неопределено
//
Функция РесурсЧастьПараметрИмя(Источник)
	
	Результат	= Неопределено;
	
	// BSLLS:MagicNumber-off - все тривиально
	Если Лев(Источник, 1) = "{" И Прав(Источник, 1) = "}" Тогда
		Результат	= Сред(Источник, 2, СтрДлина(Источник) - 2);
	КонецЕсли;
	// BSLLS:MagicNumber-on
	
	Возврат Результат;
	
КонецФункции // РесурсЧастьПараметрИмя 

#КонецОбласти

// BSLLS:CommonModuleInvalidType-on
