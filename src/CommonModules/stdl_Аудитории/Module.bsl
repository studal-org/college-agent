#Область ПрограммныйИнтерфейс
// Получить.
// 
// Параметры:
//  УИД - УникальныйИдентификатор
// 
// Возвращаемое значение:
//  - СправочникСсылка.Аудитории
//  - Неопределено
Функция Получить(УИД) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Аудитории.Ссылка
	|ИЗ
	|	Справочник.Аудитории КАК Аудитории
	|ГДЕ
	|	УНИКАЛЬНЫЙИДЕНТИФИКАТОР(Аудитории.Ссылка) = &УИД";
	
	Запрос.УстановитьПараметр("УИД", УИД);
	
	РезультатЗапроса = Запрос.Выполнить();

	Если РезультатЗапроса.Пустой() Тогда
		Возврат Неопределено;
	КонецЕсли;

	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();

	//@skip-check property-return-type
	Возврат Выборка.Ссылка;
КонецФункции
#КонецОбласти
