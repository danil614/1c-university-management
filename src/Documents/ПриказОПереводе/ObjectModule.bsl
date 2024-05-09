Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	ОбработкаЗаполненияПриказаВызовСервера.ПроверитьСтудентЕстьВТекущейГруппе(Отказ, Студенты, ТекущаяГруппа,
		ТекущийКурс, Ссылка, МоментВремени(), ЭтотОбъект);
	ОбработкаЗаполненияПриказаВызовСервера.ПроверитьКорректноеКоличествоСтаростВГруппе(Отказ, Ссылка, МоментВремени(),
		НоваяГруппа, НовыйКурс, Студенты, ЭтотОбъект);

	// Регистр Учащиеся
	Движения.Учащиеся.Записывать = Истина;
	Для Каждого СтрокаСтудент Из Студенты Цикл
		Движение = Движения.Учащиеся.Добавить();
		Движение.Период = Дата;
		Движение.Студент = СтрокаСтудент.Студент;

		Движение.Факультет = НовыйФакультет;
		Движение.УчебнаяГруппа = НоваяГруппа;
		Движение.Курс = НовыйКурс;

		Движение.ЯвляетсяСтаростой = СтрокаСтудент.ЯвляетсяСтаростой;
		Движение.ОбучениеНаБюджетнойОснове = СтрокаСтудент.ОбучениеНаБюджетнойОснове;
	КонецЦикла;


	// Регистр Взаиморасчеты
	Движения.Взаиморасчеты.Записывать = Истина;

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВзаиморасчетыОбороты.Студент КАК Студент,
	|	СУММА(ВзаиморасчетыОбороты.СуммаОборот) КАК СуммаОборот
	|ПОМЕСТИТЬ ВТ_РегистрВзаиморасчеты
	|ИЗ
	|	РегистрНакопления.Взаиморасчеты.Обороты(, &КонецПериода, Регистратор, Студент В (&Студенты)) КАК ВзаиморасчетыОбороты
	|ГДЕ
	|	(((ВзаиморасчетыОбороты.Регистратор ССЫЛКА Документ.ПриказОЗачислении
	|	ИЛИ ВзаиморасчетыОбороты.Регистратор ССЫЛКА Документ.ПриказОПереводе)
	|	И ВзаиморасчетыОбороты.Регистратор <> &Ссылка))
	|СГРУППИРОВАТЬ ПО
	|	ВзаиморасчетыОбороты.Студент
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПриказОПереводеСтуденты.Студент,
	|	ПриказОПереводеСтуденты.СуммаОбучения
	|ПОМЕСТИТЬ ВТ_ДанныеДокумента
	|ИЗ
	|	Документ.ПриказОПереводе.Студенты КАК ПриказОПереводеСтуденты
	|ГДЕ
	|	ПриказОПереводеСтуденты.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ДанныеДокумента.Студент,
	|	ВТ_ДанныеДокумента.СуммаОбучения,
	|	ЕСТЬNULL(ВТ_РегистрВзаиморасчеты.СуммаОборот, 0) КАК СуммаОборот
	|ИЗ
	|	ВТ_ДанныеДокумента КАК ВТ_ДанныеДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_РегистрВзаиморасчеты КАК ВТ_РегистрВзаиморасчеты
	|		ПО ВТ_ДанныеДокумента.Студент = ВТ_РегистрВзаиморасчеты.Студент";

	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Студенты", Студенты.ВыгрузитьКолонку("Студент"));
	Запрос.УстановитьПараметр("КонецПериода", МоментВремени());

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	Если НовыйКурс > ТекущийКурс Тогда
		// Если переводим на следующий курс, то просто добавляем сумму обучения
		Пока Выборка.Следующий() Цикл
			ДобавитьДвижениеВзаиморасчеты(ВидДвиженияНакопления.Приход, Выборка.Студент, Выборка.СуммаОбучения);
		КонецЦикла;
	Иначе
		Если НовыйКурс = ТекущийКурс Тогда
			// Если курс такой же, то проверяем остальные поля
			Если ТекущийФакультет <> НовыйФакультет Или ТекущаяГруппа <> НоваяГруппа Тогда
				// Если специальность меняется, то выполняем расчет суммы
				Пока Выборка.Следующий() Цикл
					// Делаем расход в регистре для приказов о зачислении или переводе
					ДобавитьДвижениеВзаиморасчеты(ВидДвиженияНакопления.Расход, Выборка.Студент, Выборка.СуммаОборот);
					// Делаем приход для текущей суммы обучения
					ДобавитьДвижениеВзаиморасчеты(ВидДвиженияНакопления.Приход, Выборка.Студент, Выборка.СуммаОбучения);
				КонецЦикла;
			Иначе
				// Ошибка "Новые факультет, группа и курс не должны быть равны текущим!"
				Сообщение = Новый СообщениеПользователю;
				Сообщение.Текст = "Новые факультет, группа и курс не должны быть равны текущим!";
				Сообщение.Поле = "НовыйФакультет";
				Сообщение.УстановитьДанные(ЭтотОбъект);
				Сообщение.Сообщить();
				Отказ = Истина;
			КонецЕсли;
		Иначе
			// Ошибка "Ошибка "Новый курс не может быть меньше текущего!""
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Новый курс не может быть меньше текущего!";
			Сообщение.Поле = "НовыйКурс";
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьДвижениеВзаиморасчеты(ВидДвижения, Студент, Сумма)
	Если Сумма > 0 Тогда
		Движение = Движения.Взаиморасчеты.Добавить();
		Движение.ВидДвижения = ВидДвижения;
		Движение.Период = Дата;
		Движение.Студент = Студент;
		Движение.Сумма = Сумма;
	КонецЕсли;
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	ОбработкаЗаполненияПриказаВызовСервера.ПроверитьТабличнуюЧастьСтуденты(Отказ, Студенты, ЭтотОбъект);
	ОбработкаЗаполненияПриказаВызовСервера.ПроверитьКорректностьУчебногоКурса(Отказ, ТекущийКурс, "ТекущийКурс",
		ЭтотОбъект);
	ОбработкаЗаполненияПриказаВызовСервера.ПроверитьКорректностьУчебногоКурса(Отказ, НовыйКурс, "НовыйКурс", ЭтотОбъект);
КонецПроцедуры