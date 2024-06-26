#Область ПрограммныйИнтерфейс
// Получить.
// 
// Параметры:
//  УИД - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  - Неопределено
//  - СправочникСсылка.ВидыНагрузки
Функция Получить(УИД) Экспорт
	ВидНагрузки = Справочники.ВидыНагрузки.ПолучитьСсылку(УИД);
	
	Если ВидНагрузки.ПолучитьОбъект() = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат ВидНагрузки;
КонецФункции
#КонецОбласти
