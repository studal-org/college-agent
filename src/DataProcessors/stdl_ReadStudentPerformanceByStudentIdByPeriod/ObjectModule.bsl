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

	Студент = stdl_Студенты.Получить(Новый УникальныйИдентификатор(Параметры.id));

	Если Студент = Неопределено Тогда
		ТелоОтвета = stdl_Ошибки.ReferenceNotFound("Student with provided ID was not found.", "student");
		Возврат Ответ_400_application_json(ТелоОтвета);
	КонецЕсли;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЗанятиеСтуденты.Ссылка.Дата КАК date,
	|	ЗанятиеСтуденты.Ссылка.Дисциплина КАК discipline,
	|	ЗанятиеСтуденты.Ссылка.ВидНагрузки КАК workType,
	|	ЗанятиеСтуденты.Ссылка.ВидКонтроля КАК controlType,
	|	ЗанятиеСтуденты.Оценка1 КАК mark1,
	|	ЗанятиеСтуденты.Зачет1 КАК isPassed1,
	|	ЗанятиеСтуденты.ВидКонтроля1 КАК controlType1,
	|	ЗанятиеСтуденты.Оценка2 КАК mark2,
	|	ЗанятиеСтуденты.Зачет2 КАК isPassed2,
	|	ЗанятиеСтуденты.ВидКонтроля2 КАК controlType2,
	|	ЗанятиеСтуденты.Оценка3 КАК mark3,
	|	ЗанятиеСтуденты.Зачет3 КАК isPassed3,
	|	ЗанятиеСтуденты.ВидКонтроля3 КАК controlType3,
	|	ЗанятиеСтуденты.Оценка4 КАК mark4,
	|	ЗанятиеСтуденты.Зачет4 КАК isPassed4,
	|	ЗанятиеСтуденты.ВидКонтроля4 КАК controlType4,
	|	ЗанятиеСтуденты.Оценка5 КАК mark5,
	|	ЗанятиеСтуденты.Зачет5 КАК isPassed5,
	|	ЗанятиеСтуденты.ВидКонтроля5 КАК controlType5,
	|	ЗанятиеСтуденты.Опоздание КАК isLate,
	|	ЗанятиеСтуденты.Явка КАК isAttended,
	|	ЗанятиеСтуденты.Ссылка КАК document
	|ИЗ
	|	Документ.Занятие.Студенты КАК ЗанятиеСтуденты
	|ГДЕ
	|	ЗанятиеСтуденты.Студент = &Студент
	|	И ЗанятиеСтуденты.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ЗанятиеСтуденты.Ссылка.ПометкаУдаления = ЛОЖЬ
	|	И ЗанятиеСтуденты.Ссылка.Проведен = ИСТИНА
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВедомостьСтуденты.Ссылка.Дата КАК date,
	|	ВедомостьСтуденты.Ссылка.Дисциплина КАК discipline,
	|	ВедомостьСтуденты.Ссылка.ВидНагрузки КАК workType,
	|	ВедомостьСтуденты.Ссылка.ВидКонтроля КАК controlType,
	|	ВедомостьСтуденты.Оценка КАК mark1,
	|	ВедомостьСтуденты.Зачет КАК isPassed1,
	|	ВедомостьСтуденты.Ссылка.ВидКонтроля КАК controlType1,
	|	NULL КАК mark2,
	|	NULL КАК isPassed2,
	|	NULL КАК controlType2,
	|	NULL КАК mark3,
	|	NULL КАК isPassed3,
	|	NULL КАК controlType3,
	|	NULL КАК mark4,
	|	NULL КАК isPassed4,
	|	NULL КАК controlType4,
	|	NULL КАК mark5,
	|	NULL КАК isPassed5,
	|	NULL КАК controlType5,
	|	NULL КАК isLate,
	|	ВедомостьСтуденты.Явка КАК isAttended,
	|	ВедомостьСтуденты.Ссылка КАК document
	|ИЗ
	|	Документ.Ведомость.Студенты КАК ВедомостьСтуденты
	|ГДЕ
	|	ВедомостьСтуденты.Студент = &Студент
	|	И ВедомостьСтуденты.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ВедомостьСтуденты.Ссылка.ПометкаУдаления = ЛОЖЬ
	|	И ВедомостьСтуденты.Ссылка.Проведен = ИСТИНА
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	НаправлениеНаПересдачу.Дата КАК date,
	|	НаправлениеНаПересдачу.Дисциплина КАК discipline,
	|	НаправлениеНаПересдачу.ВидНагрузки КАК workType,
	|	НаправлениеНаПересдачу.ВидКонтроля КАК controlType,
	|	НаправлениеНаПересдачу.Оценка КАК mark1,
	|	НаправлениеНаПересдачу.Зачет КАК isPassed1,
	|	НаправлениеНаПересдачу.ВидКонтроля КАК controlType1,
	|	NULL КАК mark2,
	|	NULL КАК isPassed2,
	|	NULL КАК controlType2,
	|	NULL КАК mark3,
	|	NULL КАК isPassed3,
	|	NULL КАК controlType3,
	|	NULL КАК mark4,
	|	NULL КАК isPassed4,
	|	NULL КАК controlType4,
	|	NULL КАК mark5,
	|	NULL КАК isPassed5,
	|	NULL КАК controlType5,
	|	NULL КАК isLate,
	|	NULL КАК isAttended,
	|	НаправлениеНаПересдачу.Ссылка КАК document
	|ИЗ
	|	Документ.НаправлениеНаПересдачу КАК НаправлениеНаПересдачу
	|ГДЕ
	|	НаправлениеНаПересдачу.Студент = &Студент
	|	И НаправлениеНаПересдачу.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|	И НаправлениеНаПересдачу.ПометкаУдаления = ЛОЖЬ
	|	И НаправлениеНаПересдачу.Проведен = ИСТИНА
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ПротоколГАКРезультаты.Ссылка.Дата КАК date,
	|	ПротоколГАКРезультаты.Ссылка.Дисциплина КАК discipline,
	|	NULL КАК workType,
	|	ПротоколГАКРезультаты.Ссылка.ВидКонтроля КАК controlType,
	|	ПротоколГАКРезультаты.Оценка КАК mark1,
	|	NULL КАК isPassed1,
	|	ПротоколГАКРезультаты.Ссылка.ВидКонтроля КАК controlType1,
	|	NULL КАК mark2,
	|	NULL КАК isPassed2,
	|	NULL КАК controlType2,
	|	NULL КАК mark3,
	|	NULL КАК isPassed3,
	|	NULL КАК controlType3,
	|	NULL КАК mark4,
	|	NULL КАК isPassed4,
	|	NULL КАК controlType4,
	|	NULL КАК mark5,
	|	NULL КАК isPassed5,
	|	NULL КАК controlType5,
	|	NULL КАК isLate,
	|	ВЫБОР
	|		КОГДА ПротоколГАКРезультаты.Неявка ЕСТЬ NULL
	|			ТОГДА NULL
	|		ИНАЧЕ
	|		НЕ ПротоколГАКРезультаты.Неявка
	|	КОНЕЦ КАК isAttended,
	|	ПротоколГАКРезультаты.Ссылка КАК document
	|ИЗ
	|	Документ.ПротоколГАК.Результаты КАК ПротоколГАКРезультаты
	|ГДЕ
	|	ПротоколГАКРезультаты.Студент = &Студент
	|	И ПротоколГАКРезультаты.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ПротоколГАКРезультаты.Ссылка.ПометкаУдаления = ЛОЖЬ
	|	И ПротоколГАКРезультаты.Ссылка.Проведен = ИСТИНА
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ОтчетПоПрактикеРезультатыПрактики.Ссылка.Дата КАК date,
	|	ОтчетПоПрактикеРезультатыПрактики.Ссылка.ВидПрактики КАК discipline,
	|	NULL КАК workType,
	|	ОтчетПоПрактикеРезультатыПрактики.Ссылка.ВидКонтроля КАК controlType,
	|	ОтчетПоПрактикеРезультатыПрактики.Оценка КАК mark1,
	|	ОтчетПоПрактикеРезультатыПрактики.Зачет КАК isPassed1,
	|	ОтчетПоПрактикеРезультатыПрактики.Ссылка.ВидКонтроля КАК controlType1,
	|	NULL КАК mark2,
	|	NULL КАК isPassed2,
	|	NULL КАК controlType2,
	|	NULL КАК mark3,
	|	NULL КАК isPassed3,
	|	NULL КАК controlType3,
	|	NULL КАК mark4,
	|	NULL КАК isPassed4,
	|	NULL КАК controlType4,
	|	NULL КАК mark5,
	|	NULL КАК isPassed5,
	|	NULL КАК controlType5,
	|	NULL КАК isLate,
	|	NULL КАК isAttended,
	|	ОтчетПоПрактикеРезультатыПрактики.Ссылка КАК document
	|ИЗ
	|	Документ.ОтчетПоПрактике.РезультатыПрактики КАК ОтчетПоПрактикеРезультатыПрактики
	|ГДЕ
	|	ОтчетПоПрактикеРезультатыПрактики.Студент = &Студент
	|	И ОтчетПоПрактикеРезультатыПрактики.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ОтчетПоПрактикеРезультатыПрактики.Ссылка.ПометкаУдаления = ЛОЖЬ
	|	И ОтчетПоПрактикеРезультатыПрактики.Ссылка.Проведен = ИСТИНА
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДополнительноеЗанятиеСтуденты.Ссылка.Дата КАК date,
	|	ДополнительноеЗанятиеСтуденты.Ссылка.Дисциплина КАК discipline,
	|	NULL КАК workType,
	|	NULL КАК controlType,
	|	ДополнительноеЗанятиеСтуденты.Оценка КАК mark1,
	|	NULL КАК isPassed1,
	|	NULL КАК controlType1,
	|	NULL КАК mark2,
	|	NULL КАК isPassed2,
	|	NULL КАК controlType2,
	|	NULL КАК mark3,
	|	NULL КАК isPassed3,
	|	NULL КАК controlType3,
	|	NULL КАК mark4,
	|	NULL КАК isPassed4,
	|	NULL КАК controlType4,
	|	NULL КАК mark5,
	|	NULL КАК isPassed5,
	|	NULL КАК controlType5,
	|	NULL КАК isLate,
	|	ДополнительноеЗанятиеСтуденты.Явка КАК isAttended,
	|	ДополнительноеЗанятиеСтуденты.Ссылка КАК document
	|ИЗ
	|	Документ.ДополнительноеЗанятие.Студенты КАК ДополнительноеЗанятиеСтуденты
	|ГДЕ
	|	ДополнительноеЗанятиеСтуденты.Студент = &Студент
	|	И ДополнительноеЗанятиеСтуденты.Ссылка.Дата МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ДополнительноеЗанятиеСтуденты.Ссылка.ПометкаУдаления = ЛОЖЬ
	|	И ДополнительноеЗанятиеСтуденты.Ссылка.Проведен = ИСТИНА";

	Запрос.УстановитьПараметр("Студент", Студент);
	Запрос.УстановитьПараметр("НачалоПериода", ПрочитатьДатуJSON(Параметры.periodStart, ФорматДатыJSON.ISO));
	Запрос.УстановитьПараметр("КонецПериода", ПрочитатьДатуJSON(Параметры.periodEnd, ФорматДатыJSON.ISO));

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	ДокументКНаименованию = Новый Соответствие;
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.Ведомость"), "statement");
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.НаправлениеНаПересдачу"), "retakeReferral");
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.ПротоколГАК"), "stateCertificationBoardProtocol");
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.ОтчетПоПрактике"), "practiceReport");
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.АкадемическаяСправкаВходящая"), "incomingAcademicCertificate");
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.ДополнительноеЗанятие"), "additionalClass");
	ДокументКНаименованию.Вставить(Тип("ДокументСсылка.Занятие"), "class");

	ДисциплинаКНаименованию = stdl_СоответствияНаименований.ДисциплинаКНаименованию();

	ТелоОтвета = Новый Массив; // Массив из Структура

	Пока Выборка.Следующий() Цикл
		Entry = Новый Структура;
		
		//@skip-check property-return-type
		Если НЕ ЗначениеЗаполнено(Выборка.discipline) Тогда
			Продолжить;
		Иначе
			Discipline = Новый Структура;
			//@skip-check property-return-type
			Discipline.Вставить("objectType", stdl_Утилиты.ИсключитьНеопределено(ДисциплинаКНаименованию.Получить(
				ТипЗнч(Выборка.discipline)), "Неизвестный тип дисциплины"));
			//@skip-check dynamic-access-method-not-found
			Discipline.Вставить("objectId", Выборка.discipline.УникальныйИдентификатор());
		КонецЕсли;

		Marks = Новый Массив; // Массив из Структура
		Для НомерОценки = 1 По 5 Цикл
			Оценка = СоставитьОценку(Выборка, НомерОценки);
			Если Оценка = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			Marks.Добавить(Оценка);
		КонецЦикла;

		//@skip-check property-return-type
		Entry.Вставить("objectType", stdl_Утилиты.ИсключитьНеопределено(ДокументКНаименованию.Получить(ТипЗнч(
			Выборка.document)), "Неизвестный тип документа"));
		//@skip-check dynamic-access-method-not-found
		//@skip-check property-return-type
		Entry.Вставить("objectId", Выборка.document.УникальныйИдентификатор());
		//@skip-check property-return-type
		Entry.Вставить("date", Выборка.date);
		Entry.Вставить("discipline", Discipline);
		//@skip-check property-return-type
		Entry.Вставить("workTypeId", stdl_Утилиты.ПолучитьУИДСсылки(Выборка.workType));
		//@skip-check property-return-type
		Entry.Вставить("controlTypeId", stdl_Утилиты.ПолучитьУИДСсылки(Выборка.controlType));
		//@skip-check property-return-type
		Entry.Вставить("isLate", Выборка.isLate);
		//@skip-check property-return-type
		Entry.Вставить("isAttended", Выборка.isAttended);
		Entry.Вставить("marks", Marks);
		
		ТелоОтвета.Добавить(Entry);
	КонецЦикла;

	Возврат Ответ_200_application_json(ТелоОтвета);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Составить оценку.
// 
// Параметры:
//  Выборка - ВыборкаИзРезультатаЗапроса
//  НомерОценки - Число
// 
// Возвращаемое значение:
// 	- Неопределено
//  - см. _Ответ_200_application_json_Определения.Ответ_Элемент_marks_Элемент_1
//	- см. _Ответ_200_application_json_Определения.Ответ_Элемент_marks_Элемент_2
Функция СоставитьОценку(Выборка, НомерОценки)
	Если НЕ ЗначениеЗаполнено(Выборка["controlType" + НомерОценки]) Тогда
		Возврат Неопределено;
	КонецЕсли;

	ВидКонтроля = Выборка["controlType" + НомерОценки]; // см. СправочникСсылка.ВидыКонтроля

	//@skip-check reading-attribute-from-database
	ТипОценки = ВидКонтроля.ТипОценки;
	//@skip-check reading-attribute-from-database
	Если НЕ ЗначениеЗаполнено(ТипОценки) ИЛИ ТипОценки.ЦифроваяШкала = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	//@skip-check reading-attribute-from-database
	Если ТипОценки.ЦифроваяШкала Тогда
		Если Выборка["mark" + НомерОценки] = Неопределено Или ТипОценки.НеудовлетворительноНижнийПредел = Неопределено Или Выборка["mark" + НомерОценки]
			< ТипОценки.НеудовлетворительноНижнийПредел Тогда
			Возврат Неопределено;
		КонецЕсли;
		Mark = Выборка["mark" + НомерОценки]; // Число
		Оценка = Новый Структура;
		Оценка.Вставить("number", НомерОценки);
		Оценка.Вставить("mark", Mark);
		Оценка.Вставить("controlTypeId", Строка(ВидКонтроля.УникальныйИдентификатор()));
		Возврат Оценка;
	Иначе
		Если Выборка["isPassed" + НомерОценки] = Неопределено Тогда
			Возврат Неопределено;
		КонецЕсли;
		IsPassed = Выборка["isPassed" + НомерОценки]; // Булево
		Оценка = Новый Структура;
		Оценка.Вставить("number", НомерОценки);
		Оценка.Вставить("isPassed", IsPassed);
		Оценка.Вставить("controlTypeId", Строка(ВидКонтроля.УникальныйИдентификатор()));
		//@skip-check constructor-function-return-section
		Возврат Оценка;
	КонецЕсли;
КонецФункции

// Параметры:
//	Параметры - Соответствие из КлючИЗначение -:
//		*Ключ - Произвольный
//		*Значение - Произвольный
// Возвращаемое значение:
//	Структура:
//		*id - Строка -
//		*periodEnd - Строка -
//		*periodStart - Строка -
Функция Параметры(Параметры)
	Результат = оас_Утилиты_КлиентСервер.ПолучитьСтруктуруИзСоответствия(Параметры);
	//@skip-check constructor-function-return-section
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
// Параметры:
//	Тело - см. _Ответ_400_application_json_Определения.Ответ
//
// Возвращаемое значение:
//	HTTPСервисОтвет
Функция Ответ_400_application_json(Тело)
	КодОтвета = 400;
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
//		*objectType - Строка - "statement" | "retakeReferral" | "stateCertificationBoardProtocol" | "practiceReport" | "incomingAcademicCertificate" | "additionalClass" | "class" | 
//		*objectId - Строка -
//		*date - Строка -
//		*workTypeId - Неопределено, Строка -
//		*isAttended - Неопределено, Булево -
//		*discipline - см. _Ответ_200_application_json_Определения.Ответ_Элемент_discipline
//		*controlTypeId - Неопределено, Строка -
//		*marks - Массив из см. _Ответ_200_application_json_Определения.Ответ_Элемент_marks_Элемент_1, см. _Ответ_200_application_json_Определения.Ответ_Элемент_marks_Элемент_2 - -
//		*isLate - Неопределено, Булево -
//	Ответ_Элемент_marks_Элемент_2 - Структура:
//		*number - Число -
//		*isPassed - Булево -
//		*controlTypeId - Строка -
//	Ответ_Элемент_marks_Элемент_1 - Структура:
//		*number - Число -
//		*mark - Число -
//		*controlTypeId - Строка -
//	Ответ_Элемент_discipline - Структура -:
//		*objectType - Строка - "discipline" | "practiceKind" | 
//		*objectId - Строка -
// Возвращаемое значение:
//	Неопределено
Функция _Ответ_200_application_json_Определения(Ответ_Элемент, Ответ_Элемент_marks_Элемент_2, Ответ_Элемент_marks_Элемент_1, Ответ_Элемент_discipline)
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
Функция _Ответ_400_application_json_Определения(Ответ)
	оас_Утилиты_КлиентСервер.ОшибкаТолькоДляОпределения();
	Возврат Неопределено;
КонецФункции
#КонецОбласти

#КонецОбласти

#КонецЕсли