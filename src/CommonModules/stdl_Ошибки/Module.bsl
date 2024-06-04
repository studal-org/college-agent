// @strict-types
#Область ПрограммныйИнтерфейс
// Reference not found.
// 
// Параметры:
//  Message - Строка
//  ReferenceType - Строка
// 
// Возвращаемое значение:
//  Структура:
//  	*code - Строка - "ReferenceNotFound"
//  	*message - Строка
//  	*referenceType - Строка
Функция ReferenceNotFound(Message, ReferenceType) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("code", "ReferenceNotFound");
	Результат.Вставить("message", Message);
	Результат.Вставить("referenceType", ReferenceType);
	Возврат Результат;
КонецФункции

// Not found.
// 
// Параметры:
//  Message - Строка
// 
// Возвращаемое значение:
//  Структура:
//  	*code - Строка - "NotFound"
//  	*message - Строка
Функция NotFound(Message) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("code", "NotFound");
	Результат.Вставить("message", Message);
	Возврат Результат;
КонецФункции
#КонецОбласти