Процедура ЛичнаяКарточкаСтудента(ТабДок, Ссылка) Экспорт
	// Запрос состоит из 5 частей:
	// 1. Получение текущих сведений студентов из регистра Учащиеся
	// 2. Получение всех записей по студенту по регистру Учащиеся
	// 3. Получение всех записей по студенту по регистру Взаиморасчеты
	// 4. Шапка для группировки итоговой таблицы
	// 5. Соединение всех таблиц и группировка

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	УчащиесяСрезПоследних.Студент КАК Студент,
	|	УчащиесяСрезПоследних.Факультет КАК Факультет,
	|	УчащиесяСрезПоследних.УчебнаяГруппа КАК УчебнаяГруппа,
	|	УчащиесяСрезПоследних.Курс КАК Курс,
	|	УчащиесяСрезПоследних.ЯвляетсяСтаростой КАК ЯвляетсяСтаростой,
	|	УчащиесяСрезПоследних.ОбучениеНаБюджетнойОснове КАК ОбучениеНаБюджетнойОснове
	|ПОМЕСТИТЬ ВТ_ТекущиеСведения
	|ИЗ
	|	РегистрСведений.Учащиеся.СрезПоследних КАК УчащиесяСрезПоследних
	|ГДЕ
	|	УчащиесяСрезПоследних.Студент В (&Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Учащиеся.Период КАК Период,
	|	Учащиеся.Студент КАК Студент,
	|	Учащиеся.Факультет КАК Факультет,
	|	Учащиеся.УчебнаяГруппа КАК УчебнаяГруппа,
	|	Учащиеся.Курс КАК Курс,
	|	Учащиеся.ЯвляетсяСтаростой КАК ЯвляетсяСтаростой,
	|	Учащиеся.ОбучениеНаБюджетнойОснове КАК ОбучениеНаБюджетнойОснове,
	|	""Перемещения"" КАК Регистр
	|ПОМЕСТИТЬ ВТ_ПеремещенияСтудента
	|ИЗ
	|	РегистрСведений.Учащиеся КАК Учащиеся
	|ГДЕ
	|	Учащиеся.Студент В (&Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Взаиморасчеты.Период КАК Период,
	|	Взаиморасчеты.Студент КАК Студент,
	|	Взаиморасчеты.ВидДвижения КАК ВидДвижения,
	|	Взаиморасчеты.Сумма КАК Сумма,
	|	""Взаиморасчеты"" КАК Регистр
	|ПОМЕСТИТЬ ВТ_Взаиморасчеты
	|ИЗ
	|	РегистрНакопления.Взаиморасчеты КАК Взаиморасчеты
	|ГДЕ
	|	Взаиморасчеты.Студент В (&Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Студенты.Ссылка КАК Студент,
	|	Студенты.Наименование КАК Наименование,
	|	Студенты.Пол КАК Пол,
	|	Студенты.ДатаРождения КАК ДатаРождения,
	|	Студенты.Фото КАК Фото,
	|	ВТ_ТекущиеСведения.Факультет КАК Факультет,
	|	ВТ_ТекущиеСведения.УчебнаяГруппа КАК УчебнаяГруппа,
	|	ВТ_ТекущиеСведения.Курс КАК Курс,
	|	ВТ_ТекущиеСведения.ЯвляетсяСтаростой КАК ЯвляетсяСтаростой,
	|	ВТ_ТекущиеСведения.ОбучениеНаБюджетнойОснове КАК НаБюджетнойОснове,
	|	АВТОНОМЕРЗАПИСИ() КАК Идентификатор
	|ПОМЕСТИТЬ ВТ_Шапка
	|ИЗ
	|	Справочник.Студенты КАК Студенты
	|		ЛЕВОЕ СОЕДИНЕНИЕ ВТ_ТекущиеСведения КАК ВТ_ТекущиеСведения
	|		ПО Студенты.Ссылка = ВТ_ТекущиеСведения.Студент
	|ГДЕ
	|	Студенты.Ссылка В (&Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.Период КАК ПериодТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.Факультет КАК ФакультетТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.УчебнаяГруппа КАК УчебнаяГруппаТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.Курс КАК КурсТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.ЯвляетсяСтаростой КАК ЯвляетсяСтаростойТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.ОбучениеНаБюджетнойОснове КАК НаБюджетнойОсновеТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.ВидДвижения КАК ВидДвиженияТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.Сумма КАК СуммаТаблица,
	|	Запрос_ПеремещенияСтудента_Взаиморасчеты.Регистр КАК Регистр,
	|	ВТ_Шапка.Наименование КАК Наименование,
	|	ВТ_Шапка.Пол КАК Пол,
	|	ВТ_Шапка.ДатаРождения КАК ДатаРождения,
	|	ВТ_Шапка.Факультет КАК Факультет,
	|	ВТ_Шапка.УчебнаяГруппа КАК УчебнаяГруппа,
	|	ВТ_Шапка.Курс КАК Курс,
	|	ВТ_Шапка.ЯвляетсяСтаростой КАК ЯвляетсяСтаростой,
	|	ВТ_Шапка.НаБюджетнойОснове КАК НаБюджетнойОснове,
	|	ВТ_Шапка.Фото КАК Фото
	|ИЗ
	|	ВТ_Шапка КАК ВТ_Шапка
	|		ЛЕВОЕ СОЕДИНЕНИЕ (ВЫБРАТЬ
	|			ВТ_ПеремещенияСтудента.Период КАК Период,
	|			ВТ_ПеремещенияСтудента.Студент КАК Студент,
	|			ВТ_ПеремещенияСтудента.Факультет КАК Факультет,
	|			ВТ_ПеремещенияСтудента.УчебнаяГруппа КАК УчебнаяГруппа,
	|			ВТ_ПеремещенияСтудента.Курс КАК Курс,
	|			ВТ_ПеремещенияСтудента.ЯвляетсяСтаростой КАК ЯвляетсяСтаростой,
	|			ВТ_ПеремещенияСтудента.ОбучениеНаБюджетнойОснове КАК ОбучениеНаБюджетнойОснове,
	|			"""" КАК ВидДвижения,
	|			"""" КАК Сумма,
	|			ВТ_ПеремещенияСтудента.Регистр КАК Регистр
	|		ИЗ
	|			ВТ_ПеремещенияСтудента КАК ВТ_ПеремещенияСтудента
	|
	|		ОБЪЕДИНИТЬ ВСЕ
	|
	|		ВЫБРАТЬ
	|			ВТ_Взаиморасчеты.Период,
	|			ВТ_Взаиморасчеты.Студент,
	|			"""",
	|			"""",
	|			"""",
	|			"""",
	|			"""",
	|			ВТ_Взаиморасчеты.ВидДвижения,
	|			ВТ_Взаиморасчеты.Сумма,
	|			ВТ_Взаиморасчеты.Регистр
	|		ИЗ
	|			ВТ_Взаиморасчеты КАК ВТ_Взаиморасчеты) КАК Запрос_ПеремещенияСтудента_Взаиморасчеты
	|		ПО ВТ_Шапка.Студент = Запрос_ПеремещенияСтудента_Взаиморасчеты.Студент
	|
	|УПОРЯДОЧИТЬ ПО
	|	ПериодТаблица
	|ИТОГИ
	|	МАКСИМУМ(Наименование),
	|	МАКСИМУМ(Пол),
	|	МАКСИМУМ(ДатаРождения),
	|	МАКСИМУМ(Факультет),
	|	МАКСИМУМ(УчебнаяГруппа),
	|	МАКСИМУМ(Курс),
	|	МАКСИМУМ(ЯвляетсяСтаростой),
	|	МАКСИМУМ(НаБюджетнойОснове),
	|	МАКСИМУМ(Фото) КАК Фото
	|ПО
	|	ВТ_Шапка.Идентификатор,
	|	Регистр";

	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);

	Макет = ПолучитьМакет("ЛичнаяКарточкаСтудента");

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	
	// Таблица перемещений
	ЗаголовокПеремещения = Макет.ПолучитьОбласть("ЗаголовокПеремещения");
	СтрокаПеремещения = Макет.ПолучитьОбласть("СтрокаПеремещения");
	
	// Таблица взаиморасчетов
	ЗаголовокВзаиморасчеты = Макет.ПолучитьОбласть("ЗаголовокВзаиморасчеты");
	СтрокаВзаиморасчеты = Макет.ПолучитьОбласть("СтрокаВзаиморасчеты");

	ТабДок.Очистить();
	ВставлятьРазделительСтраниц = Ложь;

	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);
		
		// Заполняем шапку
		Шапка.Параметры.Заполнить(Выборка);
		Шапка.Параметры.ДатаРождения = Формат(Выборка.ДатаРождения, "ДЛФ=DD");

		// Вставляем фото студента
		Фото = Выборка.Фото;
		Если ЗначениеЗаполнено(Фото) Тогда
			Шапка.Рисунки.Фото.Картинка = Новый Картинка(Фото.Файл.Получить(), Истина);
		Иначе
			Шапка.Рисунки.Фото.Картинка = Новый Картинка();
		КонецЕсли;

		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ВыборкаРегистр = Выборка.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	    // Идем по таблице регистра
		Пока ВыборкаРегистр.Следующий() Цикл
			Если ВыборкаРегистр.Регистр = "Перемещения" Тогда
				ТабДок.Вывести(ЗаголовокПеремещения);
			ИначеЕсли ВыборкаРегистр.Регистр = "Взаиморасчеты" Тогда
				ТабДок.Вывести(ЗаголовокВзаиморасчеты);
			КонецЕсли;

			ВыборкаДетальныеЗаписи = ВыборкаРегистр.Выбрать();
	        // Выводим строки таблицы
			Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
				Если ВыборкаРегистр.Регистр = "Перемещения" Тогда
					СтрокаПеремещения.Параметры.Заполнить(ВыборкаДетальныеЗаписи);
					ТабДок.Вывести(СтрокаПеремещения);
				ИначеЕсли ВыборкаРегистр.Регистр = "Взаиморасчеты" Тогда
					СтрокаВзаиморасчеты.Параметры.Заполнить(ВыборкаДетальныеЗаписи);
					ТабДок.Вывести(СтрокаВзаиморасчеты);
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
КонецПроцедуры