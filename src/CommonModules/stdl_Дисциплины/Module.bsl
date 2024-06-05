#Область ПрограммныйИнтерфейс
// Получить.
// 
// Параметры:
//  УИД - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  - СправочникСсылка.Дисциплины
//  - Неопределено
Функция Получить(УИД) Экспорт
	Дисциплина = Справочники.Дисциплины.ПолучитьСсылку(УИД);
	
	Если Дисциплина.ПолучитьОбъект() = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Дисциплина;
КонецФункции
#КонецОбласти
