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
	Параметры = Параметры(оас_Контекст.Параметры(Контекст));
	
	Дисциплина = stdl_Дисциплины.Получить(Новый УникальныйИдентификатор(Параметры.id));
	
	Если Дисциплина = Неопределено Тогда
		ТелоОтвета = stdl_Ошибки.ReferenceNotFound("Discipline with provided ID was not found.", "discipline");
		Возврат Ответ_404_application_json(ТелоОтвета);
	КонецЕсли;
	
	ТелоОтвета = stdl_Модели.Discipline(Дисциплина);
	
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
//		*id - Строка -
Функция Параметры(Параметры)
	Результат = оас_Утилиты_КлиентСервер.ПолучитьСтруктуруИзСоответствия(Параметры);
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

#Область Ответы

// Параметры:
//	Тело - см. _Ответ_200_application_json_Определения.Ответ
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
// Параметры:
//	Тело - см. _Ответ_404_application_json_Определения.Ответ
//
// Возвращаемое значение:
//	HTTPСервисОтвет
Функция Ответ_404_application_json(Тело)
	КодОтвета = 404;
	Ответ = Новый HTTPСервисОтвет(КодОтвета);

	ТелоСтрокой = stdl_JSONКлиентСервер.Записать(Тело);
	Ответ.УстановитьТелоИзСтроки(ТелоСтрокой);

	Возврат Ответ;
КонецФункции


#КонецОбласти

#Область Определения

//@skip-check module-unused-method
// Параметры:
//	
// Возвращаемое значение:
//	Неопределено
Функция _Параметры_Определения()
	оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	Возврат Неопределено;
КонецФункции

//@skip-check module-unused-method
// Параметры:
//	Ответ - Структура -:
//		*id - Строка -
//		*title - Строка -
//		*shortTitle - Строка -
//		*fullTitle - Неопределено, Строка -
// Возвращаемое значение:
//	Неопределено
Функция _Ответ_200_application_json_Определения(Ответ)
	оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	Возврат Неопределено;
КонецФункции
//@skip-check module-unused-method
// Параметры:
//	Ответ - Структура -:
//		*code - Строка - "ReferenceNotFound"
//		*message - Строка -
//		*referenceType - Строка -
// Возвращаемое значение:
//	Неопределено
Функция _Ответ_404_application_json_Определения(Ответ)
	оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	Возврат Неопределено;
КонецФункции


#КонецОбласти

#КонецОбласти

#КонецЕсли