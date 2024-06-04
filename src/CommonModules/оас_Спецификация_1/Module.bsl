// @strict-types
#Область ПрограммныйИнтерфейс

// Десериализировать спецификацию.
// 
// Параметры:
//  СтрокаJSON - Строка
// 
// Возвращаемое значение:
//  см. СобратьСпецификацию
Функция ДесериализироватьСпецификацию(СтрокаJSON) Экспорт
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(СтрокаJSON);

	Спецификация = ПрочитатьJSON(Чтение, Истина, , ФорматДатыJSON.ISO);
	
	Если ТипЗнч(Спецификация) = Тип("Соответствие") Тогда
		Возврат СобратьСпецификацию(Спецификация);
	КонецЕсли;

	ВызватьИсключение "Спецификация должна быть объектом"
КонецФункции

// Заменить ссылки значениями.
// 
// Параметры:
//  Спецификация - см. СобратьСпецификацию
// 
// Возвращаемое значение:
//  см. СобратьСпецификацию
Функция ЗаменитьСсылкиЗначениями(Спецификация) Экспорт
	//@skip-check constructor-function-return-section
	Возврат ЗаменитьСсылкиЗначениямиОбход(Спецификация, Спецификация);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Собрать спецификацию.
// 
// Параметры:
//  Спецификация - Соответствие из КлючИЗначение:
//  	*Ключ - Произвольный
//  	*Значение - Произвольный
// 
// Возвращаемое значение:
//  см. OpenAPIObject
Функция СобратьСпецификацию(Спецификация)
	Возврат OpenAPIObject(Спецификация);
КонецФункции

#Область Objects

#Область OpenAPI

// Open APIObject.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//		*openapi - Строка
//		*info - см. InfoObject
//		*jsonSchemaDialect - Неопределено, Строка -
//		*servers - Неопределено, см. OpenAPIObject_Servers -
//		*paths - Неопределено, см. PathsObject -
//		*webhooks
//		*components - Неопределено, см. ComponentsObject -
//		*security
//		*tags
//		*externalDocs - Неопределено, см. ExternalDocumentationObject -
Функция OpenAPIObject(Object) Экспорт
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("jsonSchemaDialect");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Info = Object.Получить("info"); // см. InfoObject.Object
	Servers = Object.Получить("servers"); // Неопределено, см. OpenAPIObject_Servers.Servers
	Paths = Object.Получить("paths"); // Неопределено, см. PathsObject.Object
	Components = Object.Получить("components"); // Неопределено, см. ComponentsObject.Object

	Результат.Вставить("info", InfoObject(Info));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("servers", ?(Servers <> Неопределено, OpenAPIObject_Servers(Servers), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("paths", ?(Paths <> Неопределено, PathsObject(Paths), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("components", ?(Components <> Неопределено, ComponentsObject(Components), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Open APIObject servers.
// 
// Параметры:
//  Servers - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. ServerObject
Функция OpenAPIObject_Servers(Servers)
	Результат = Новый Массив; // см. OpenAPIObject_Servers

	Для Каждого Server_ Из Servers Цикл
		Результат.Добавить(ServerObject(Server_));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

// Info object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//		*title - Строка
//		*summary - Неопределено, Строка -
//		*description - Неопределено, Строка -
//		*termsOfService - Неопределено, Строка -
//		*contact - Неопределено, см. ContactObject - 
//		*license - Неопределено, см. LicenseObject - 
//		*version - Строка
Функция InfoObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("summary");
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("termsOfService");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Contact = Object.Получить("contact"); // Неопределено, см. ContactObject.Object
	License = Object.Получить("license"); // Неопределено, см. LicenseObject.Object

	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("contact", ?(Contact <> Неопределено, ContactObject(Contact), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("license", ?(License <> Неопределено, LicenseObject(License), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Contact object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*name - Неопределено, Строка -
//  	*url - Неопределено, Строка -
//  	*email - Неопределено, Строка -
Функция ContactObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("name");
	ВозможноНеопределенныеЗначения.Добавить("url");
	ВозможноНеопределенныеЗначения.Добавить("email");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// License object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*name - Строка -
//  	*identifier - Неопределено, Строка -
//  	*url - Неопределено, Строка -
Функция LicenseObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("identifier");
	ВозможноНеопределенныеЗначения.Добавить("url");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

#Область Server

// Server object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*url - Строка
//  	*description - Неопределено, Строка -
//  	*variables - Неопределено, см. ServerObject_Variables -
Функция ServerObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("description");

	Variables = Object.Получить("variables"); // Неопределено, см. ServerObject_Variables.Variables
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("variables", ?(Variables <> Неопределено, ServerObject_Variables(Variables), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Server object variables.
// 
// Параметры:
//  Variables - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение -	см. ServerVariableObject
Функция ServerObject_Variables(Variables)
	Результат = Новый Соответствие;

	Для Каждого Variable Из Variables Цикл
		Ключ = Variable.Ключ;
		Значение = Variable.Значение; // см. ServerVariableObject.Object
		Результат.Вставить(Ключ, ServerVariableObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

// Server variable object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*enum - Неопределено, Массив из Строка -
//  	*default - Строка
//  	*description - Неопределено, Строка -
Функция ServerVariableObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("enum");
	ВозможноНеопределенныеЗначения.Добавить("description");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

#Область Components

// Components object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*schemas - Неопределено, см. ComponentsObject_Schemas -
Функция ComponentsObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	Schemas = Object.Получить("schemas"); // Неопределено, см. ComponentsObject_Schemas.Object
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("schemas", ?(Schemas <> Неопределено, ComponentsObject_Schemas(Schemas), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Components object schemas.
// 
// Параметры:
//  Schemas - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. SchemaObject
Функция ComponentsObject_Schemas(Schemas)
	Результат = Новый Соответствие;
	
	Для Каждого Schema Из Schemas Цикл
		Ключ = Schema.Ключ;
		Значение = Schema.Значение; // см. SchemaObject.Object
		Результат.Вставить(Ключ, SchemaObject(Значение));
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

// Paths object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. PathItemObject
Функция PathsObject(Object) Экспорт
	Результат = Новый Соответствие;

	Для Каждого PathItem Из Object Цикл
		Ключ = PathItem.Ключ;
		Значение = PathItem.Значение; // см. PathItemObject.Object
		Результат.Вставить(Ключ, PathItemObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#Область PathItem

// Path item object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*_dollarSign_ref - Неопределено, Строка -
//  	*summary - Неопределено, Строка -
//  	*description - Неопределено, Строка -
//  	*get - Неопределено, см. OperationObject -
//  	*put - Неопределено, см. OperationObject -
//  	*post - Неопределено, см. OperationObject -
//  	*delete - Неопределено, см. OperationObject -
//  	*options - Неопределено, см. OperationObject -
//  	*head - Неопределено, см. OperationObject -
//  	*patch - Неопределено, см. OperationObject -
//  	*trace - Неопределено, см. OperationObject -
//  	*servers - Неопределено, см. PathItemObject_Servers -
//  	*parameters - Неопределено, см. PathItemObject_Parameters -
Функция PathItemObject(Object) Экспорт
	Результат = ПолучитьСтруктуруИзСоответствия(ПереименоватьЗнакДоллара(Object));

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_ref");
	ВозможноНеопределенныеЗначения.Добавить("summary");
	ВозможноНеопределенныеЗначения.Добавить("description");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Методы = Новый Массив; // Массив из Строка
	Методы.Добавить("get");
	Методы.Добавить("put");
	Методы.Добавить("post");
	Методы.Добавить("delete");
	Методы.Добавить("options");
	Методы.Добавить("head");
	Методы.Добавить("patch");
	Методы.Добавить("trace");

	Для Каждого Метод Из Методы Цикл
		OperationObject_ = Object.Получить(Метод); // Неопределено, см. OperationObject.Object
		//@skip-check invocation-parameter-type-intersect
		Результат.Вставить(Метод, ?(OperationObject_ <> Неопределено, OperationObject(OperationObject_), Неопределено));
	КонецЦикла;

	Servers = Object.Получить("servers"); // Неопределено, см. PathItemObject_Servers.Servers
	Parameters = Object.Получить("parameters"); // Неопределено, см. PathItemObject_Parameters.Parameters
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("servers", ?(Servers <> Неопределено, PathItemObject_Servers(Servers), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("parameters", ?(Parameters <> Неопределено, PathItemObject_Parameters(Parameters), Неопределено));

	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Path item object servers.
// 
// Параметры:
//  Servers - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. ServerObject
Функция PathItemObject_Servers(Servers)
	Результат = Новый Массив; // см. PathItemObject_Servers

	Для Каждого Server_ Из Servers Цикл
		Результат.Добавить(ServerObject(Server_));
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Path item object parameters.
// 
// Параметры:
//  Parameters - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. ParameterObject, см. ReferenceObject
Функция PathItemObject_Parameters(Parameters)
	Результат = Новый Массив; // см. PathItemObject_Parameters

	Для Каждого Parameter Из Parameters Цикл
		Ref = ПреобразоватьВReferenceObject(Parameter);
		Если Ref <> Неопределено Тогда
			Результат.Добавить(Ref);
		Иначе
			Результат.Добавить(ParameterObject(Parameter));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

#Область Operation

// Operation object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*tags - Неопределено, Массив из Строка -
//  	*summary - Неопределено, Строка -
//  	*description - Неопределено, Строка -
//  	*externalDocs - Неопределено, см. ExternalDocumentationObject -
//  	*operationId - Неопределено, Строка -
//  	*parameters - Неопределено, см. OperationObject_Parameters -
//  	*requestBody - Неопределено, см. OperationObject_RequestBody -
//  	*responses - Неопределено, см. ResponsesObject -
//  	*callbacks - 
//  	*deprecated - Неопределено, Булево -
//  	*security - 
//  	*servers - Неопределено, см. OperationObject_Servers -
Функция OperationObject(Object) Экспорт
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("tags");
	ВозможноНеопределенныеЗначения.Добавить("summary");
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("operationId");	
	ВозможноНеопределенныеЗначения.Добавить("deprecated");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	ExternalDocs = Object.Получить("externalDocs"); // Неопределено, см. ExternalDocumentationObject.Object
	Parameters = Object.Получить("parameters"); // Неопределено, см. OperationObject_Parameters.Parameters
	RequestBody = Object.Получить("requestBody"); // Неопределено, см. OperationObject_RequestBody.RequestBody
	Responses = Object.Получить("responses"); // Неопределено, см. ResponsesObject.Object
	Servers = Object.Получить("servers"); // Неопределено, см. OperationObject_Servers.Servers
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("externalDocs", ?(ExternalDocs <> Неопределено, ExternalDocumentationObject(ExternalDocs),
		Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("parameters", ?(Parameters <> Неопределено, OperationObject_Parameters(Parameters),
		Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("requestBody", ?(RequestBody <> Неопределено, OperationObject_RequestBody(RequestBody),
		Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("responses", ?(Responses <> Неопределено, ResponsesObject(Responses), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("servers", ?(Servers <> Неопределено, OperationObject_Servers(Servers), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Operation object parameters.
// 
// Параметры:
//  Parameters - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. ParameterObject, см. ReferenceObject
Функция OperationObject_Parameters(Parameters)
	Результат = Новый Массив; // см. OperationObject_Parameters

	Для Каждого Parameter Из Parameters Цикл
		Ref = ПреобразоватьВReferenceObject(Parameter);
		Если Ref <> Неопределено Тогда
			Результат.Добавить(Ref);
		Иначе
			Результат.Добавить(ParameterObject(Parameter));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Operation object request body.
// 
// Параметры:
//  RequestBody - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  - Структура
//  - см. RequestBodyObject
//  - см. ReferenceObject
Функция OperationObject_RequestBody(RequestBody)
	Ref = ПреобразоватьВReferenceObject(RequestBody);
	Если Ref <> Неопределено Тогда
		Возврат Ref;
	Иначе
		Возврат RequestBodyObject(RequestBody);
	КонецЕсли;
КонецФункции

// Operation object servers.
// 
// Параметры:
//  Servers - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. ServerObject
Функция OperationObject_Servers(Servers)
	Результат = Новый Массив; // см. OperationObject_Servers

	Для Каждого Server_ Из Servers Цикл
		Результат.Добавить(ServerObject(Server_));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

// External documentation object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*description - Неопределено, Строка -
//  	*url - Строка
Функция ExternalDocumentationObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("description");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

#Область Parameter

// Parameter object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*name - Строка
//  	*in - Строка
//  	*description - Неопределено, Строка -
//  	*required - Неопределено, Булево - 
//  	*deprecated - Неопределено, Булево - 
//  	*allowEmptyValue - Неопределено, Булево - 
//  	
//  	*style - Неопределено, Строка -
//  	*explode - Неопределено, Булево -
//  	*allowReserved - Неопределено, Булево -
//  	*schema - Неопределено, см. SchemaObject - 
//  	*examples - Неопределено, см. ParameterObject_Examples -
//  		
//  	*content - Неопределено, см. ParameterObject_Content -
Функция ParameterObject(Object) Экспорт
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("required");
	ВозможноНеопределенныеЗначения.Добавить("deprecated");
	ВозможноНеопределенныеЗначения.Добавить("allowEmptyValue");	
	ВозможноНеопределенныеЗначения.Добавить("style");
	ВозможноНеопределенныеЗначения.Добавить("explode");
	ВозможноНеопределенныеЗначения.Добавить("allowReserved");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Schema = Object.Получить("schema"); // Неопределено, см. SchemaObject.Object
	Examples = Object.Получить("examples"); // Неопределено, см. ParameterObject_Examples.Examples
	Content = Object.Получить("content"); // Неопределено, см. ParameterObject_Content.Content

	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("schema", ?(Schema <> Неопределено, SchemaObject(Schema), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("examples", ?(Examples <> Неопределено, ParameterObject_Examples(Examples), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("content", ?(Content <> Неопределено, ParameterObject_Content(Content), Неопределено));

	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Parameter object examples.
// 
// Параметры:
//  Examples - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. ExampleObject, см. ReferenceObject -
Функция ParameterObject_Examples(Examples)
	Результат = Новый Соответствие;

	Для Каждого Example Из Examples Цикл
		Ключ = Example.Ключ;
		Значение = Example.Значение; // см. ExampleObject.Object, см. ReferenceObject.Object
		//@skip-check invocation-parameter-type-intersect
		Ref = ПреобразоватьВReferenceObject(Значение);
		Если Ref <> Неопределено Тогда
			Результат.Вставить(Ключ, Ref);
		Иначе
			//@skip-check invocation-parameter-type-intersect
			Результат.Вставить(Ключ, ExampleObject(Значение));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Parameter object content.
// 
// Параметры:
//  Content - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. MediaTypeObject
Функция ParameterObject_Content(Content) Экспорт
	Результат = Новый Соответствие;

	Для Каждого MediaType Из Content Цикл
		Ключ = MediaType.Ключ;
		Значение = MediaType.Ключ; // см. MediaTypeObject.Object
		Результат.Вставить(Ключ, MediaTypeObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

#Область RequestBody

// Request body object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*description - Неопределено, Строка -
//  	*content - см. RequestBodyObject_Content
//  	*required - Неопределено, Булево -
Функция RequestBodyObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("required");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Content = Object.Получить("content"); // см. RequestBodyObject_Content.Content

	Результат.Вставить("content", RequestBodyObject_Content(Content));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Request body object content.
// 
// Параметры:
//  Content - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. MediaTypeObject
Функция RequestBodyObject_Content(Content)
	Результат = Новый Соответствие;

	Для Каждого MediaType Из Content Цикл
		Ключ = MediaType.Ключ;
		Значение = MediaType.Ключ; // см. MediaTypeObject.Object
		Результат.Вставить(Ключ, MediaTypeObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

#Область MediaType

// Media type object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*schema - Неопределено, см. SchemaObject -
//  	*example - Неопределено, Произвольный - 
//  	*examples - Неопределено, см. MediaTypeObject_Examples -
//  	*encoding - Неопределено, см. MediaTypeObject_Encoding -
Функция MediaTypeObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("example");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Schema = Object.Получить("schema"); // Неопределено, см. SchemaObject.Object
	Examples = Object.Получить("examples"); // Неопределено, см. MediaTypeObject_Examples.Examples
	Encoding = Object.Получить("encoding"); // Неопределено, см. MediaTypeObject_Encoding.Content

	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("schema", ?(Schema <> Неопределено, SchemaObject(Schema), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("examples", ?(Examples <> Неопределено, MediaTypeObject_Examples(Examples), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("encoding", ?(Encoding <> Неопределено, MediaTypeObject_Encoding(Encoding), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Media type object examples.
// 
// Параметры:
//  Examples - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. ExampleObject, см. ReferenceObject -
Функция MediaTypeObject_Examples(Examples)
	Результат = Новый Соответствие;

	Для Каждого Example Из Examples Цикл
		Ключ = Example.Ключ;
		Значение = Example.Значение; // см. ExampleObject.Object, см. ReferenceObject.Object
		//@skip-check invocation-parameter-type-intersect
		Ref = ПреобразоватьВReferenceObject(Значение);
		Если Ref <> Неопределено Тогда
			Результат.Вставить(Ключ, Ref);
		Иначе
			//@skip-check invocation-parameter-type-intersect
			Результат.Вставить(Ключ, ExampleObject(Значение));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Media type object encoding.
// 
// Параметры:
//  Encoding - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. EncodingObject
Функция MediaTypeObject_Encoding(Encoding)
	Результат = Новый Соответствие;

	Для Каждого PropertyName_Encoding Из Encoding Цикл
		Ключ = PropertyName_Encoding.Ключ;
		Значение = PropertyName_Encoding.Значение; // см. EncodingObject.Object
		Результат.Вставить(Ключ, EncodingObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

#Область Encoding

// Encoding object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*contentType - Неопределено, Строка -
//  	*headers - Неопределено, см. EncodingObject_Headers -
//  	*style - Неопределено, Строка -
//  	*explode - Неопределено, Булево -
//  	*allowReserved - Неопределено, Булево -
Функция EncodingObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("contentType");
	ВозможноНеопределенныеЗначения.Добавить("style");
	ВозможноНеопределенныеЗначения.Добавить("explode");
	ВозможноНеопределенныеЗначения.Добавить("allowReserved");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Headers = Object.Получить("headers"); // Неопределено, см. EncodingObject_Headers.Headers
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("headers", ?(Headers <> Неопределено, EncodingObject_Headers(Headers), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Encoding object headers.
// 
// Параметры:
//  Headers - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. HeaderObject, см. ReferenceObject -
Функция EncodingObject_Headers(Headers)
	Результат = Новый Соответствие;

	Для Каждого Header Из Headers Цикл
		Ключ = Header.Ключ;
		Значение = Header.Значение; // см. HeaderObject.Object, см. ReferenceObject.Object
		//@skip-check invocation-parameter-type-intersect
		Ref = ПреобразоватьВReferenceObject(Значение);
		Если Ref <> Неопределено Тогда
			Результат.Вставить(Ключ, Ref);
		Иначе
			//@skip-check invocation-parameter-type-intersect
			Результат.Вставить(Ключ, HeaderObject(Значение));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

// Responses object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. ResponseObject
Функция ResponsesObject(Object) Экспорт
	Результат = Новый Соответствие;

	Для Каждого Response Из Object Цикл
		Ключ = Response.Ключ;
		Значение = Response.Значение; // см. ResponseObject.Object
		Результат.Вставить(Ключ, ResponseObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#Область Response

// Response object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*description - Строка
//  	*headers - Неопределено, см. ResponseObject_Headers -
//  	*content - Неопределено, см. ResponseObject_Content -
//  	*links - Неопределено, см. ResponseObject_Links -
Функция ResponseObject(Object) Экспорт
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	Headers = Object.Получить("headers"); // Неопределено, см. ResponseObject_Headers.Headers
	Content = Object.Получить("content"); // Неопределено, см. ResponseObject_Content.Content
	Links = Object.Получить("links"); // Неопределено, см. ResponseObject_Links.Links
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("headers", ?(Headers <> Неопределено, ResponseObject_Headers(Headers), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("content", ?(Content <> Неопределено, ResponseObject_Content(Content), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("links", ?(Links <> Неопределено, ResponseObject_Links(Links), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Response object headers.
// 
// Параметры:
//  Headers - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. HeaderObject, см. ReferenceObject -
Функция ResponseObject_Headers(Headers)
	Результат = Новый Соответствие;

	Для Каждого Header Из Headers Цикл
		Ключ = Header.Ключ;
		Значение = Header.Значение; // см. HeaderObject.Object, см. ReferenceObject.Object
		//@skip-check invocation-parameter-type-intersect
		Ref = ПреобразоватьВReferenceObject(Значение);
		Если Ref <> Неопределено Тогда
			Результат.Вставить(Ключ, Ref);
		Иначе
			//@skip-check invocation-parameter-type-intersect
			Результат.Вставить(Ключ, HeaderObject(Значение));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Response object content.
// 
// Параметры:
//  Content - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. MediaTypeObject
Функция ResponseObject_Content(Content) Экспорт
	Результат = Новый Соответствие;

	Для Каждого MediaType Из Content Цикл
		Ключ = MediaType.Ключ;
		Значение = MediaType.Значение; // см. MediaTypeObject.Object
		Результат.Вставить(Ключ, MediaTypeObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Response object links.
// 
// Параметры:
//  Links - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. LinkObject, см. ReferenceObject -
Функция ResponseObject_Links(Links)
	Результат = Новый Соответствие;

	Для Каждого Link Из Links Цикл
		Ключ = Link.Ключ;
		Значение = Link.Значение; // см. LinkObject.Object, см. ReferenceObject.Object
		//@skip-check invocation-parameter-type-intersect
		Ref = ПреобразоватьВReferenceObject(Значение);
		Если Ref <> Неопределено Тогда
			Результат.Вставить(Ключ, Ref);
		Иначе
			//@skip-check invocation-parameter-type-intersect
			Результат.Вставить(Ключ, LinkObject(Значение));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

// Example object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*summary - Неопределено, Строка - 
//  	*description - Неопределено, Строка - 
//  	*value - Неопределено, Произвольный - 
//  	*externalValue - Неопределено, Строка - 
Функция ExampleObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("summary");
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("value");
	ВозможноНеопределенныеЗначения.Добавить("externalValue");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

#Область Link

// Link object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*operationRef - Неопределено, Строка -
//  	*operationId - Неопределено, Строка -
//  	*parameters - Неопределено, см. LinkObject_Parameters -
//  	*requestBody - Неопределено, Произвольный -
//  	*description - Неопределено, Строка -
//  	*server - Неопределено, см. ServerObject -
Функция LinkObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("operationRef");
	ВозможноНеопределенныеЗначения.Добавить("operationId");
	ВозможноНеопределенныеЗначения.Добавить("requestBody");
	ВозможноНеопределенныеЗначения.Добавить("description");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Parameters = Object.Получить("parameters"); // Неопределено, см. LinkObject_Parameters.Parameters
	Server_ = Object.Получить("server"); // Неопределено, см. ServerObject.Object
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("parameters", ?(Parameters <> Неопределено, LinkObject_Parameters(Parameters), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("server", ?(Server_ <> Неопределено, ServerObject(Server_), Неопределено));
	
	Возврат Результат;
КонецФункции

// Link object parameters.
// 
// Параметры:
//  Parameters - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - Произвольный
Функция LinkObject_Parameters(Parameters)
	Возврат Parameters;
КонецФункции

#КонецОбласти

#Область Header

// Header object.
// 
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*description - Неопределено, Строка -
//  	*required - Неопределено, Булево - 
//  	*deprecated - Неопределено, Булево - 
//  	*allowEmptyValue - Неопределено, Булево - 
//  	
//  	*style - Неопределено, Строка -
//  	*explode - Неопределено, Булево -
//  	*allowReserved - Неопределено, Булево -
//  	*schema - Неопределено, см. SchemaObject - 
//  	*examples - Неопределено, см. HeaderObject_Examples -
//  		
//  	*content - Неопределено, см. HeaderObject_Content -
Функция HeaderObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(Object);

	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("required");
	ВозможноНеопределенныеЗначения.Добавить("deprecated");
	ВозможноНеопределенныеЗначения.Добавить("allowEmptyValue");
	ВозможноНеопределенныеЗначения.Добавить("style");
	ВозможноНеопределенныеЗначения.Добавить("explode");
	ВозможноНеопределенныеЗначения.Добавить("allowReserved");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);

	Schema = Object.Получить("schema"); // Неопределено, см. SchemaObject.Object
	Examples = Object.Получить("examples"); // Неопределено, см. HeaderObject_Examples.Examples
	Content = Object.Получить("content"); // Неопределено, см. HeaderObject_Content.Content

	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("schema", ?(Schema <> Неопределено, SchemaObject(Schema), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("examples", ?(Examples <> Неопределено, HeaderObject_Examples(Examples), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("content", ?(Content <> Неопределено, HeaderObject_Content(Content), Неопределено));

	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Header object examples.
// 
// Параметры:
//  Examples - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. ExampleObject, см. ReferenceObject -
Функция HeaderObject_Examples(Examples)
	Результат = Новый Соответствие;

	Для Каждого Example Из Examples Цикл
		Ключ = Example.Ключ;
		Значение = Example.Значение; // см. ExampleObject.Object, см. ReferenceObject.Object
		//@skip-check invocation-parameter-type-intersect
		Ref = ПреобразоватьВReferenceObject(Значение);
		Если Ref <> Неопределено Тогда
			Результат.Вставить(Ключ, Ref);
		Иначе
			//@skip-check invocation-parameter-type-intersect
			Результат.Вставить(Ключ, ExampleObject(Значение));
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Header object content.
// 
// Параметры:
//  Content - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. MediaTypeObject
Функция HeaderObject_Content(Content)
	Результат = Новый Соответствие;

	Для Каждого MediaType Из Content Цикл
		Ключ = MediaType.Ключ;
		Значение = MediaType.Ключ; // см. MediaTypeObject.Object
		Результат.Вставить(Ключ, MediaTypeObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

#КонецОбласти

// Reference object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*_dollarSign_ref - Строка
//  	*summary - Неопределено, Строка -
//  	*description - Неопределено, Строка -
Функция ReferenceObject(Object)
	//@skip-check constructor-function-return-section
	Результат = ПолучитьСтруктуруИзСоответствия(ПереименоватьЗнакДоллара(Object));
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_ref");
	ВозможноНеопределенныеЗначения.Добавить("summary");
	ВозможноНеопределенныеЗначения.Добавить("description");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	Возврат Результат
КонецФункции

#Область Schema

// Schema object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*title - Неопределено, Строка -
//  	*description - Неопределено, Строка -
//  	*default - Неопределено, Произвольный -
//  	*deprecated - Неопределено, Булево -
//  	*readOnly - Неопределено, Булево -
//  	*writeOnly - Неопределено, Булево -
//  	*examples - Неопределено, Массив из Произвольный -
//  	
//  	*type - Неопределено, Строка -
//  	*enum - Неопределено, Массив из Строка -
//  	*const - Неопределено, Произвольный -
//  	
//  	*multipleOf - Неопределено, Число -
//  	*maximum - Неопределено, Число -
//  	*exclusiveMaximum - Неопределено, Число -
//  	*minimum - Неопределено, Число -
//  	*exclusiveMinimum - Неопределено, Число -
//  	
// 		*minLength - Неопределено, Число -
//		*maxLength - Неопределено, Число -
//		*pattern - Неопределено, Строка -
//		
//		*maxItems - Неопределено, Число -
//		*minItems - Неопределено, Число -
//		*uniqueItems - Неопределено, Булево -
//		*maxContains - Неопределено, Число -
//		*minContains - Неопределено, Число -
//		*prefixItems - Неопределено, см. SchemaObject_PrefixItems -
//		*items - Неопределено, см. SchemaObject -
//		*contains - Неопределено, см. SchemaObject -
//		
//		*maxProperties - Неопределено, Число -
//		*minProperties - Неопределено, Число -
//		*required - Неопределено, Массив из Строка -
//		*dependentRequired - Неопределено, см. SchemaObject_DependentRequired -
//		*properties - Неопределено, см. SchemaObject_Properties -
//		*patternProperties - Неопределено, см. SchemaObject_PatternProperties -
//		*additionalProperties - Неопределено, см. SchemaObject -
//		*propertyNames - Неопределено, см. SchemaObject -
//		
//		*format - Неопределено, Строка -
//		
//		*contentEncoding - Неопределено, Строка -
//		*contentMediaType - Неопределено, Строка -
//		*contentSchema - Неопределено, Строка -
//
//		*allOf - Неопределено, см. SchemaObject_Array -
//		*anyOf - Неопределено, см. SchemaObject_Array -
//		*oneOf - Неопределено, см. SchemaObject_Array -
//		*not - Неопределено, см. SchemaObject -
//
//		*if - Неопределено, см. SchemaObject -
//		*then - Неопределено, см. SchemaObject -
//		*else - Неопределено, см. SchemaObject -
//		*dependentSchemas - Неопределено, см. SchemaObject_DependentSchemas -
//
//		*_dollarSign_schema - Неопределено, Строка -
//		*_dollarSign_vocabulary - Неопределено, см. SchemaObject_DollarSign_Vocabulary -
//		*_dollarSign_id - Неопределено, Строка -
//		*_dollarSign_ref - Неопределено, Строка -
//		*_dollarSign_dynamicRef - Неопределено, Строка -
//		*_dollarSign_defs - Неопределено, см. SchemaObject_DollarSign_Defs -
//		*_dollarSign_comment - Неопределено, Строка -
//		*_dollarSign_anchor - Неопределено, Строка -
//		*_dollarSign_dynamicAnchor - Неопределено, Строка -
//
//  	*discriminator - Неопределено, см. DiscriminatorObject -
//  	*xml - Неопределено, см. XMLObject -
//  	*externalDocs - Неопределено, см. ExternalDocumentationObject -
//  	*example - Неопределено, Произвольный -
Функция SchemaObject(Object) Экспорт
	Результат = ПолучитьСтруктуруИзСоответствия(ПереименоватьЗнакДоллара(Object));
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("title");
	ВозможноНеопределенныеЗначения.Добавить("description");
	ВозможноНеопределенныеЗначения.Добавить("default");
	ВозможноНеопределенныеЗначения.Добавить("deprecated");
	ВозможноНеопределенныеЗначения.Добавить("readOnly");
	ВозможноНеопределенныеЗначения.Добавить("writeOnly");
	ВозможноНеопределенныеЗначения.Добавить("examples");
	ВозможноНеопределенныеЗначения.Добавить("type");
	ВозможноНеопределенныеЗначения.Добавить("enum");
	ВозможноНеопределенныеЗначения.Добавить("const");
	ВозможноНеопределенныеЗначения.Добавить("multipleOf");
	ВозможноНеопределенныеЗначения.Добавить("maximum");
	ВозможноНеопределенныеЗначения.Добавить("exclusiveMaximum");
	ВозможноНеопределенныеЗначения.Добавить("minimum");
	ВозможноНеопределенныеЗначения.Добавить("exclusiveMinimum");
	ВозможноНеопределенныеЗначения.Добавить("minLength");
	ВозможноНеопределенныеЗначения.Добавить("maxLength");
	ВозможноНеопределенныеЗначения.Добавить("pattern");
	ВозможноНеопределенныеЗначения.Добавить("maxItems");
	ВозможноНеопределенныеЗначения.Добавить("minItems");
	ВозможноНеопределенныеЗначения.Добавить("uniqueItems");
	ВозможноНеопределенныеЗначения.Добавить("maxContains");
	ВозможноНеопределенныеЗначения.Добавить("minContains");
	ВозможноНеопределенныеЗначения.Добавить("maxProperties");
	ВозможноНеопределенныеЗначения.Добавить("minProperties");
	ВозможноНеопределенныеЗначения.Добавить("required");
	ВозможноНеопределенныеЗначения.Добавить("format");
	ВозможноНеопределенныеЗначения.Добавить("contentEncoding");
	ВозможноНеопределенныеЗначения.Добавить("contentMediaType");
	ВозможноНеопределенныеЗначения.Добавить("contentSchema");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_schema");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_id");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_ref");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_dynamicRef");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_comment");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_anchor");
	ВозможноНеопределенныеЗначения.Добавить("_dollarSign_dynamicAnchor");
	ВозможноНеопределенныеЗначения.Добавить("example");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	PrefixItems = Object.Получить("prefixItems"); // Неопределено, см. SchemaObject_PrefixItems.PrefixItems
	Items = Object.Получить("items"); // Неопределено, см. SchemaObject.Object
	Contains = Object.Получить("contains"); // Неопределено, см. SchemaObject.Object
	DependentRequired = Object.Получить("dependentRequired"); // Неопределено, см. SchemaObject_DependentRequired.DependentRequired
	Properties = Object.Получить("properties"); // Неопределено, см. SchemaObject_Properties.Properties
	PatternProperties = Object.Получить("patternProperties"); // Неопределено, см. SchemaObject_PatternProperties.PatternProperties
	AdditionalProperties = Object.Получить("additionalProperties"); // Неопределено, см. SchemaObject.Object
	PropertyNames = Object.Получить("propertyNames"); // Неопределено, см. SchemaObject.Object
	AllOf = Object.Получить("allOf"); // Неопределено, Массив из см. SchemaObject.Object
	AnyOf = Object.Получить("anyOf"); // Неопределено, Массив из см. SchemaObject.Object
	OneOf = Object.Получить("oneOf"); // Неопределено, Массив из см. SchemaObject.Object
	Not_ = Object.Получить("not"); // Неопределено, см. SchemaObject.Object
	If_ = Object.Получить("if"); // Неопределено, см. SchemaObject.Object
	Then_ = Object.Получить("then"); // Неопределено, см. SchemaObject.Object
	Else_ = Object.Получить("else"); // Неопределено, см. SchemaObject.Object
	DependentSchemas = Object.Получить("dependentSchemas"); // Неопределено, см. SchemaObject_DependentSchemas.DependentSchemas
	DollarSign_Vocabulary = Object.Получить("_dollarSign_vocabulary"); // Неопределено, см. SchemaObject_DollarSign_Vocabulary.DollarSign_Vocabulary
	DollarSign_Defs = Object.Получить("_dollarSign_defs"); // Неопределено, см. SchemaObject_DollarSign_Defs.DollarSign_Defs
	Discriminator = Object.Получить("discriminator"); // Неопределено, см. DiscriminatorObject.Object
	Xml = Object.Получить("xml"); // Неопределено, см. XMLObject.Object
	ExternalDocs = Object.Получить("externalDocs"); // Неопределено, см. ExternalDocumentationObject.Object
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("prefixItems", ?(PrefixItems <> Неопределено, SchemaObject_PrefixItems(PrefixItems), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("items", ?(Items <> Неопределено, SchemaObject(Items), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("contains", ?(Contains <> Неопределено, SchemaObject(Contains), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("dependentRequired", ?(DependentRequired <> Неопределено, SchemaObject_DependentRequired(DependentRequired), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("properties", ?(Properties <> Неопределено, SchemaObject_Properties(Properties), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("patternProperties", ?(PatternProperties <> Неопределено, SchemaObject_PatternProperties(PatternProperties), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("additionalProperties", ?(AdditionalProperties <> Неопределено, SchemaObject(AdditionalProperties), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("propertyNames", ?(PropertyNames <> Неопределено, SchemaObject(PropertyNames), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("allOf", ?(AllOf <> Неопределено, SchemaObject_Array(AllOf), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("anyOf", ?(AnyOf <> Неопределено, SchemaObject_Array(AnyOf), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("oneOf", ?(OneOf <> Неопределено, SchemaObject(OneOf), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("not", ?(Not_ <> Неопределено, SchemaObject(Not_), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("if", ?(If_ <> Неопределено, SchemaObject(If_), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("then", ?(Then_ <> Неопределено, SchemaObject(Then_), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("else", ?(Else_ <> Неопределено, SchemaObject(Else_), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("dependentSchemas", ?(DependentSchemas <> Неопределено, SchemaObject_DependentSchemas(DependentSchemas), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("_dollarSign_vocabulary", ?(DollarSign_Vocabulary <> Неопределено, SchemaObject_DollarSign_Vocabulary(DollarSign_Vocabulary), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("_dollarSign_defs", ?(DollarSign_Defs <> Неопределено, SchemaObject_DollarSign_Defs(DollarSign_Defs), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("discriminator", ?(Discriminator <> Неопределено, DiscriminatorObject(Discriminator), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("xml", ?(Xml <> Неопределено, XMLObject(Xml), Неопределено));
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("externalDocs", ?(ExternalDocs <> Неопределено, ExternalDocumentationObject(ExternalDocs), Неопределено));
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

// Schema object dependent required.
// 
// Параметры:
//  DependentRequired - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//		*Ключ - Строка
//		*Значение - Массив из Строка
Функция SchemaObject_DependentRequired(DependentRequired) Экспорт
	Возврат DependentRequired
КонецФункции

// Schema object dependent schemas.
// 
// Параметры:
//  DependentSchemas - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//		*Ключ - Строка
//		*Значение - см. SchemaObject
Функция SchemaObject_DependentSchemas(DependentSchemas)
	Результат = Новый Соответствие;

	Для Каждого DependentSchema Из DependentSchemas Цикл
		Ключ = DependentSchema.Ключ;
		Значение = DependentSchema.Значение; // см. SchemaObject.Object
		Результат.Вставить(Ключ, SchemaObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Schema object prefix items.
// 
// Параметры:
//  PrefixItems - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. SchemaObject
Функция SchemaObject_PrefixItems(PrefixItems) Экспорт
	Результат = Новый Массив; // см. SchemaObject_PrefixItems

	Для Каждого PrefixItem Из PrefixItems Цикл
		Результат.Добавить(SchemaObject(PrefixItem));
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Schema object properties.
// 
// Параметры:
//  Properties - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. SchemaObject
Функция SchemaObject_Properties(Properties) Экспорт
	Результат = Новый Соответствие;

	Для Каждого Property Из Properties Цикл
		Ключ = Property.Ключ;
		Значение = Property.Значение; // см. SchemaObject.Object
		Результат.Вставить(Ключ, SchemaObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Schema object pattern properties.
// 
// Параметры:
//  PatternProperties - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. SchemaObject
Функция SchemaObject_PatternProperties(PatternProperties) Экспорт
	Результат = Новый Соответствие;

	Для Каждого PatternProperty Из PatternProperties Цикл
		Ключ = PatternProperty.Ключ;
		Значение = PatternProperty.Значение; // см. SchemaObject.Object
		Результат.Вставить(Ключ, SchemaObject(Значение));
	КонецЦикла;

	Возврат Результат;
КонецФункции

// Schema object dollar sign vocabulary.
// 
// Параметры:
//  DollarSign_Vocabulary - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - Булево
Функция SchemaObject_DollarSign_Vocabulary(DollarSign_Vocabulary)
	Возврат DollarSign_Vocabulary;
КонецФункции

// Schema object dollar sign defs.
// 
// Параметры:
//  DollarSign_Defs - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - см. SchemaObject
Функция SchemaObject_DollarSign_Defs(DollarSign_Defs)
	Результат = Новый Соответствие;
	
	Для Каждого Def Из DollarSign_Defs Цикл
		Ключ = Def.Ключ;
		Значение = Def.Значение; // см. SchemaObject.Object
		Результат.Вставить(Ключ, SchemaObject(Значение));
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

// Schema object array.
// 
// Параметры:
//  Array - Массив из см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Массив из см. SchemaObject
Функция SchemaObject_Array(Array) Экспорт
	Результат = Новый Массив; // см. SchemaObject_Array
	
	Для Каждого Object Из Array Цикл
		Результат.Добавить(SchemaObject(Object))
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

#Область Discriminator

// Discriminator object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*propertyName - Строка
//  	*mapping - Соответствие из КлючИЗначение:
//  		*Ключ - Строка
//  		*Значение - Строка
Функция DiscriminatorObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(ПереименоватьЗнакДоллара(Object));
	
	Mapping = Object.Получить("mapping"); // Неопределено, см. DiscriminatorObject_Mapping.Mapping
	
	//@skip-check invocation-parameter-type-intersect
	Результат.Вставить("mapping", ?(Mapping <> Неопределено, DiscriminatorObject_Mapping(Mapping), Неопределено));
	
	Возврат Результат;
КонецФункции

// Discriminator object mapping.
// 
// Параметры:
//  Mapping - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение:
//  	*Ключ - Строка
//  	*Значение - Строка
Функция DiscriminatorObject_Mapping(Mapping)
	Возврат Mapping;
КонецФункции

#КонецОбласти

// XML object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  Структура:
//  	*name - Неопределено, Строка -
//  	*namespace - Неопределено, Строка -
//  	*prefix - Неопределено, Строка -
//  	*attribute - Неопределено, Булево -
//  	*wrapped - Неопределено, Булево -
Функция XMLObject(Object)
	Результат = ПолучитьСтруктуруИзСоответствия(ПереименоватьЗнакДоллара(Object));
	
	ВозможноНеопределенныеЗначения = Новый Массив; // см. ЗаполнитьВозможноНеопределенныеЗначения.Имена
	ВозможноНеопределенныеЗначения.Добавить("name");
	ВозможноНеопределенныеЗначения.Добавить("namespace");
	ВозможноНеопределенныеЗначения.Добавить("prefix");
	ВозможноНеопределенныеЗначения.Добавить("attribute");
	ВозможноНеопределенныеЗначения.Добавить("wrapped");
	
	ЗаполнитьВозможноНеопределенныеЗначения(Результат, ВозможноНеопределенныеЗначения);
	
	//@skip-check constructor-function-return-section
	Возврат Результат;
КонецФункции

#КонецОбласти

// Преобразовать в reference object.
// 
// Параметры:
//  Object - см. СобратьСпецификацию.Спецификация
// 
// Возвращаемое значение:
//  - Неопределено
//  - см. ReferenceObject
Функция ПреобразоватьВReferenceObject(Object)
	Если Object.Получить("$ref") <> Неопределено Тогда
		Возврат ReferenceObject(Object);
	КонецЕсли;
	Возврат Неопределено;
КонецФункции



// Заменить ссылки значениями обход.
// 
// Параметры:
//  Источник - Произвольный
//  Спецификация - см. СобратьСпецификацию
// 
// Возвращаемое значение:
//  Произвольный
Функция ЗаменитьСсылкиЗначениямиОбход(Источник, Спецификация)
	Если ТипЗнч(Источник) = Тип("Структура") Тогда
		Возврат ЗаменитьСсылкиЗначениямиОбход_Структура(Источник, Спецификация);
	ИначеЕсли ТипЗнч(Источник) = Тип("Соответствие") Тогда
		Возврат ЗаменитьСсылкиЗначениямиОбход_Соответствие(Источник, Спецификация);
	ИначеЕсли ТипЗнч(Источник) = Тип("Массив") Тогда
		Возврат ЗаменитьСсылкиЗначениямиОбход_Массив(Источник, Спецификация);
	Иначе
		Возврат Источник;
	КонецЕсли;
КонецФункции

// Заменить ссылки значениями обход структура.
// 
// Параметры:
//  Источник - Структура
//  Спецификация - см. СобратьСпецификацию
// 
// Возвращаемое значение:
//  Структура
Функция ЗаменитьСсылкиЗначениямиОбход_Структура(Источник, Спецификация)
	Ref = Неопределено; // Неопределено, Строка
	Источник.Свойство("_dollarSign_ref", Ref);
	Если Ref <> Неопределено Тогда
		Результат = Источник;
		Результат.Удалить("_dollarSign_ref");
		ЗначениеСсылки = ПолучитьЗначениеСсылки(Ref, Спецификация);
		Для Каждого Свойство Из ЗначениеСсылки Цикл
			Результат.Вставить(Свойство.Ключ, ЗаменитьСсылкиЗначениямиОбход(Свойство.Значение, Спецификация));
		КонецЦикла;
	Иначе
		Результат = Источник;		
		Для Каждого Свойство Из Источник Цикл
			Результат.Вставить(Свойство.Ключ, ЗаменитьСсылкиЗначениямиОбход(Свойство.Значение, Спецификация));
		КонецЦикла;
	КонецЕсли;
	Возврат Результат;
КонецФункции

// Заменить ссылки значениями обход соответствие.
// 
// Параметры:
//  Источник - Соответствие из КлючИЗначение:
//  	*Ключ - Строка
//  	*Значение - см. ЗаменитьСсылкиЗначениямиОбход.Источник
//  Спецификация - см. СобратьСпецификацию
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение:
//  	*Ключ - Строка
//  	*Значение - см. ЗаменитьСсылкиЗначениямиОбход
Функция ЗаменитьСсылкиЗначениямиОбход_Соответствие(Источник, Спецификация)
	Ref = Источник.Получить("_dollarSign_ref"); // Неопределено, Строка
	Если Ref <> Неопределено Тогда
		Результат = Источник;
		Результат.Удалить("_dollarSign_ref");
		ЗначениеСсылки = ПолучитьЗначениеСсылки(Ref, Спецификация);
		Для Каждого Свойство Из ЗначениеСсылки Цикл
			Результат.Вставить(Свойство.Ключ, ЗаменитьСсылкиЗначениямиОбход(Свойство.Значение, Спецификация));
		КонецЦикла;
		Возврат Результат;
	Иначе
		Результат = Источник;		
		Для Каждого Свойство Из Источник Цикл
			Результат.Вставить(Свойство.Ключ, ЗаменитьСсылкиЗначениямиОбход(Свойство.Значение, Спецификация));
		КонецЦикла;
	КонецЕсли;
	Возврат Результат;
КонецФункции

// Заменить ссылки значениями обход массив.
// 
// Параметры:
//  Источник - Массив из см. ЗаменитьСсылкиЗначениямиОбход.Источник
//  Спецификация - см. СобратьСпецификацию
// 
// Возвращаемое значение:
//  Массив из см. ЗаменитьСсылкиЗначениямиОбход
Функция ЗаменитьСсылкиЗначениямиОбход_Массив(Источник, Спецификация)
	Результат = Новый Массив; // см. ЗаменитьСсылкиЗначениямиОбход_Массив
	
	Для Каждого Элемент Из Источник Цикл
		//@skip-check typed-value-adding-to-untyped-collection
		Результат.Добавить(ЗаменитьСсылкиЗначениямиОбход(Элемент, Спецификация))
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

// Получить значение ссылки.
// 
// Параметры:
//  Ссылка - Строка
//  Спецификация - см. СобратьСпецификацию
// 
// Возвращаемое значение:
//  - Структура
//  - Соответствие
Функция ПолучитьЗначениеСсылки(Ссылка, Спецификация)
	//@skip-check dynamic-access-method-not-found
	Путь = оас_Модуль.ом_Строка().ВМассив(Ссылка, "/"); // Массив из Строка

	Если Не Путь.Количество() Или Не Путь[0] = "#" Тогда
		ВызватьИсключение "Неудалось получить значение ссылки - некорректный путь"
	КонецЕсли;
	
	Путь.Удалить(0);
	Источник = Спецификация; 
	Для Каждого ЧастьПути Из Путь Цикл
		Если ТипЗнч(Источник) = Тип("Структура") Тогда			
			Источник = Источник[ЧастьПути]; // Структура, Соответствие
		ИначеЕсли ТипЗнч(Источник) = Тип("Соответствие") Тогда
			Источник = Источник.Получить(ЧастьПути); // Структура, Соответствие
		Иначе
			ВызватьИсключение "Неудалось получить значение ссылки - часть пути ссылается на необрабатываемое свойство";
		КонецЕсли;
	КонецЦикла;

	Возврат Источник;
КонецФункции

// см. оас_Утилиты_КлиентСервер.ПолучитьСтруктуруИзСоответствия
Функция ПолучитьСтруктуруИзСоответствия(ЗначВход) Экспорт
	Возврат оас_Утилиты_КлиентСервер.ПолучитьСтруктуруИзСоответствия(ЗначВход);
КонецФункции


// Переименовать знак доллара.
// 
// Параметры:
//  ЗначВход - Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - Произвольный
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение -:
//  	*Ключ - Строка
//  	*Значение - Произвольный
Функция ПереименоватьЗнакДоллара(ЗначВход)
	Результат = Новый Соответствие;
	
	Для Каждого Элемент Из ЗначВход Цикл
		Ключ = СтрЗаменить(Элемент.Ключ, "$", "_dollarSign_");
		Значение = Элемент.Значение;
		Результат.Вставить(Ключ, Значение);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

// Заполнить возможно неопределенные значения.
// 
// Параметры:
//  Object - Структура
//  Имена - Массив из Строка
Процедура ЗаполнитьВозможноНеопределенныеЗначения(Object, Имена)
	Для Каждого Имя Из Имена Цикл
		Значение = Неопределено;
		Object.Свойство(Имя, Значение);
		Если Значение = Неопределено Тогда
			Object.Вставить(Имя, Значение);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти