// @strict-types
#Если Сервер Тогда

#Область ПрограммныйИнтерфейс

// Обработчик.
// 
// Параметры:
//	Контекст - Структура
// 
// Возвращаемое значение:
//	HTTPСервисОтвет
Функция Обработчик(Контекст) Экспорт
	УчебныеГруппы = stdl_УчебныеГруппы.Перечислить();
	
	ТелоОтвета = Новый Массив; // Массив из см. _Ответ_200_application_json_Определения.Ответ_Элемент
	Для Каждого УчебнаяГруппа Из УчебныеГруппы Цикл
		ТелоОтвета.Добавить(stdl_Модели.Group(УчебнаяГруппа));
	КонецЦикла;
	
	Возврат Ответ_200_application_json(ТелоОтвета);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//	Параметры - Соответствие из КлючИЗначение -:
//		*Ключ - Произвольный
//		*Значение - Произвольный
// Возвращаемое значение:
//	Структура:
//		
Функция Параметры(Параметры)
	Результат = оас_Утилиты_КлиентСервер.ПолучитьСтруктуруИзСоответствия(Параметры);
	Возврат Результат;
КонецФункции

#Область Ответы

// Параметры:
//	Тело - Массив из см. _Ответ_200_application_json_Определения.Ответ_Элемент -
//
// Возвращаемое значение:
//	HTTPСервисОтвет
Функция Ответ_200_application_json(Тело)
	КодОтвета = 200;
	Ответ = Новый HTTPСервисОтвет(КодОтвета);

	ТелоСтрокой = stdl_JSONКлиентСервер.Записать(Тело);
	Ответ.УстановитьТелоИзСтроки(ТелоСтрокой);

	Возврат Ответ;
КонецФункции

#КонецОбласти

#Область Определения

//@skip-check module-unused-method
// Возвращаемое значение:
//	Неопределено
Функция _Параметры_Определения()
	оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	Возврат Неопределено;
КонецФункции

//@skip-check module-unused-method
// Параметры:
//	Ответ_Элемент - Структура -:
//		*id - Строка -
//		*title - Строка -
// Возвращаемое значение:
//	Неопределено
Функция _Ответ_200_application_json_Определения(Ответ_Элемент)
	оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	Возврат Неопределено;
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли