Процедура ПроверитьТабличнуюЧастьСтуденты(Отказ, Студенты, ЭтотОбъект) Экспорт
	Для Каждого СтрокаСтудент Из Студенты Цикл
		Если СтрокаСтудент.ОбучениеНаБюджетнойОснове И СтрокаСтудент.СуммаОбучения > 0 Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = СтрШаблон(
				"Студент ""%1"" учится на бюджетной основе и имеет положительную сумму обучения!",
				СтрокаСтудент.Студент);
			Сообщение.Поле = СтрШаблон("Студенты[%1].СуммаОбучения", СтрокаСтудент.НомерСтроки - 1);
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
		КонецЕсли;
		Если Не СтрокаСтудент.ОбучениеНаБюджетнойОснове И СтрокаСтудент.СуммаОбучения = 0 Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = СтрШаблон(
				"Студент ""%1"" не учится на бюджетной основе и не имеет сумму обучения!", СтрокаСтудент.Студент);
			Сообщение.Поле = СтрШаблон("Студенты[%1].СуммаОбучения", СтрокаСтудент.НомерСтроки - 1);
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Процедура ПроверитьКорректностьУчебногоКурса(Отказ, Курс, ПолеКурса, ЭтотОбъект) Экспорт
	КоличествоВозможныхКурсов = Константы.КоличествоВозможныхКурсов.Получить();

	Если Курс > КоличествоВозможныхКурсов Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СтрШаблон(
				"Курс ""%1"" больше максимально возможного курса ""%2""!", Курс, КоличествоВозможныхКурсов);
		Сообщение.Поле = ПолеКурса;
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьКорректноеКоличествоСтаростВГруппе(Отказ, Регистратор, Период, УчебнаяГруппа, Курс, Студенты,
	ЭтотОбъект) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Студенты.Студент КАК Студент,
	|	Студенты.ЯвляетсяСтаростой КАК ЯвляетсяСтаростой
	|ПОМЕСТИТЬ ВТ_Студенты
	|ИЗ
	|	&Студенты КАК Студенты
	|ГДЕ
	|	Студенты.ЯвляетсяСтаростой
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВТ_Студенты.Студент) КАК КоличествоСтарост,
	|	ВТ_Студенты.ЯвляетсяСтаростой
	|ИЗ
	|	ВТ_Студенты КАК ВТ_Студенты
	|СГРУППИРОВАТЬ ПО
	|	ВТ_Студенты.ЯвляетсяСтаростой";

	Запрос.УстановитьПараметр("Студенты", Студенты);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	КоличествоСтаростВПриказе = 0;

	Если Выборка.Следующий() Тогда
		КоличествоСтаростВПриказе = Выборка.КоличествоСтарост;
	КонецЕсли;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ УчащиесяСрезПоследних.Студент) КАК КоличествоСтарост,
	|	УчащиесяСрезПоследних.УчебнаяГруппа
	|ИЗ
	|	РегистрСведений.Учащиеся.СрезПоследних(&Период, Регистратор <> &Регистратор) КАК УчащиесяСрезПоследних
	|ГДЕ
	|	УчащиесяСрезПоследних.УчебнаяГруппа = &УчебнаяГруппа
	|	И УчащиесяСрезПоследних.ЯвляетсяСтаростой = ИСТИНА
	|	И УчащиесяСрезПоследних.Курс = &Курс
	|СГРУППИРОВАТЬ ПО
	|	УчащиесяСрезПоследних.УчебнаяГруппа";

	Запрос.УстановитьПараметр("УчебнаяГруппа", УчебнаяГруппа);
	Запрос.УстановитьПараметр("Курс", Курс);
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	Запрос.УстановитьПараметр("Период", Период);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	КоличествоСтаростВРегистре = 0;

	Если Выборка.Следующий() Тогда
		КоличествоСтаростВРегистре = Выборка.КоличествоСтарост;
	КонецЕсли;

	Если КоличествоСтаростВПриказе + КоличествоСтаростВРегистре > 1 Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СтрШаблон(
				"Количество старост больше максимально возможного! Старост в приказе: %1. Старост в регистре: %2.",
			КоличествоСтаростВПриказе, КоличествоСтаростВРегистре);
		Сообщение.Поле = "Студенты";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьСтудентНеУчится(Отказ, Студенты, Регистратор, Период, ЭтотОбъект) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПриказОЗачисленииСтуденты.НомерСтроки,
	|	ПриказОЗачисленииСтуденты.Студент
	|ПОМЕСТИТЬ ВТ_ДанныеДокумента
	|ИЗ
	|	Документ.ПриказОЗачислении.Студенты КАК ПриказОЗачисленииСтуденты
	|ГДЕ
	|	ПриказОЗачисленииСтуденты.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	УчащиесяСрезПоследних.Студент,
	|	ВТ_ДанныеДокумента.НомерСтроки КАК НомерСтроки,
	|	УчащиесяСрезПоследних.УчебнаяГруппа,
	|	УчащиесяСрезПоследних.Курс
	|ИЗ
	|	РегистрСведений.Учащиеся.СрезПоследних(&Период, Регистратор <> &Ссылка) КАК УчащиесяСрезПоследних
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента
	|		ПО УчащиесяСрезПоследних.Студент = ВТ_ДанныеДокумента.Студент
	|ГДЕ
	|	УчащиесяСрезПоследних.Студент В (&Студенты)
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";

	Запрос.УстановитьПараметр("Студенты", Студенты.ВыгрузитьКолонку("Студент"));
	Запрос.УстановитьПараметр("Ссылка", Регистратор);
	Запрос.УстановитьПараметр("Период", Период);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	Пока Выборка.Следующий() Цикл
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СтрШаблон(
				"Студент ""%1"" уже учится в группе ""%2"" на %3 курсе!", Выборка.Студент, Выборка.УчебнаяГруппа,
			Выборка.Курс);
		Сообщение.Поле = СтрШаблон("Студенты[%1].Студент", Выборка.НомерСтроки - 1);
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЦикла;
КонецПроцедуры

Процедура ПроверитьСтудентЕстьВТекущейГруппе(Отказ, Студенты, ТекущаяГруппа, ТекущийКурс, Регистратор, Период,
	ЭтотОбъект) Экспорт
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПриказОПереводеСтуденты.НомерСтроки,
	|	ПриказОПереводеСтуденты.Студент
	|ПОМЕСТИТЬ ВТ_ДанныеДокумента
	|ИЗ
	|	Документ.ПриказОПереводе.Студенты КАК ПриказОПереводеСтуденты
	|ГДЕ
	|	ПриказОПереводеСтуденты.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	УчащиесяСрезПоследних.Студент,
	|	УчащиесяСрезПоследних.УчебнаяГруппа,
	|	УчащиесяСрезПоследних.Курс
	|ПОМЕСТИТЬ ВТ_ДанныеРегистра
	|ИЗ
	|	РегистрСведений.Учащиеся.СрезПоследних(&Период, Регистратор <> &Ссылка) КАК УчащиесяСрезПоследних
	|ГДЕ
	|	УчащиесяСрезПоследних.Студент В (&Студенты)
	|	И УчащиесяСрезПоследних.УчебнаяГруппа = &УчебнаяГруппа
	|	И УчащиесяСрезПоследних.Курс = &Курс
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеДокумента.Студент,
	|	ВТ_ДанныеДокумента.НомерСтроки КАК НомерСтроки,
	|	ВТ_ДанныеРегистра.УчебнаяГруппа,
	|	ВТ_ДанныеРегистра.Курс
	|ИЗ
	|	ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ДанныеРегистра КАК ВТ_ДанныеРегистра
	|		ПО ВТ_ДанныеДокумента.Студент = ВТ_ДанныеРегистра.Студент
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";

	Запрос.УстановитьПараметр("Студенты", Студенты.ВыгрузитьКолонку("Студент"));
	Запрос.УстановитьПараметр("Ссылка", Регистратор);
	Запрос.УстановитьПараметр("Период", Период);
	Запрос.УстановитьПараметр("УчебнаяГруппа", ТекущаяГруппа);
	Запрос.УстановитьПараметр("Курс", ТекущийКурс);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	Пока Выборка.Следующий() Цикл
		Если Не ЗначениеЗаполнено(Выборка.УчебнаяГруппа) Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = СтрШаблон(
					"Студент ""%1"" не учится в группе ""%2"" на %3 курсе!", Выборка.Студент, ТекущаяГруппа,
				ТекущийКурс);
			Сообщение.Поле = СтрШаблон("Студенты[%1].Студент", Выборка.НомерСтроки - 1);
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры