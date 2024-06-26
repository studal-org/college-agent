// BSLLS:CommonModuleInvalidType-off - тип модуля верен, может вызываться только в серверном контексте
// 
// Кэш сервиса
//  

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает объект обработки по заданному имени
//
// Параметры: 
// 	Сервис - Строка - Идентификатор сервиса. 
// 	Имя - Строка - Полное имя обработки
//
// Возвращаемое значение: 
// 	ОбработкаОбъект
//
Функция ОбработкаОбъект(Сервис, Имя) Экспорт
	
	Результат	= Неопределено;
	
	Части	= оас_Модуль.ом_Строка().ВМассив(Имя, ".");
	// BSLLS:MagicNumber-off - излишне
	Если Части.Количество() = 2 И Метаданные.Обработки.Найти(Части[1]) <> Неопределено Тогда
		УстановитьПривилегированныйРежим(Истина);
		Результат	= Обработки[Части[1]].Создать();
	КонецЕсли;
	// BSLLS:MagicNumber-on
	
	Возврат Результат;
	
КонецФункции // ОбработкаОбъект

#КонецОбласти

// BSLLS:CommonModuleInvalidType-on
