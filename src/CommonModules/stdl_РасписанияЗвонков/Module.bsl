#Область ПрограммныйИнтерфейс
// Получить.
// 
// Параметры:
//  УИД - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  - Неопределено
//  - СправочникСсылка.РасписанияЗвонков
Функция Получить(УИД) Экспорт
	РасписаниеЗвонков = Справочники.РасписанияЗвонков.ПолучитьСсылку(УИД);
	
	Если РасписаниеЗвонков.ПолучитьОбъект() = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат РасписаниеЗвонков;
КонецФункции
#КонецОбласти