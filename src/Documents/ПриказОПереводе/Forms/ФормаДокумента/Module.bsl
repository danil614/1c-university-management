&НаКлиенте
Процедура ПолучитьСтудентов(Команда)
	ПолучитьСтудентовНаСервере(Объект.ТекущаяГруппа, Объект.ТекущийФакультет, Объект.ТекущийКурс, Объект.Ссылка);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗапретИзмененияДокументовВызовСервера.ЗапретитьИзменениеЗакрытогоДокумента(Объект, ТолькоПросмотр);
КонецПроцедуры

&НаСервере
Процедура ПолучитьСтудентовНаСервере(УчебнаяГруппа, Факультет, Курс, Регистратор)
	Студенты = ПолучениеСтудентовВызовСервера.ПолучитьСтудентовИзРегистра(УчебнаяГруппа, Факультет, Курс, Регистратор,
		ЭтотОбъект);

	Если ЗначениеЗаполнено(Студенты) Тогда
		Объект.Студенты.Загрузить(Студенты);
	КонецЕсли;
КонецПроцедуры