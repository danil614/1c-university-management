#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	Движения.Оценки.Записывать = Истина;

	Для Каждого СтудентОценка Из Оценки Цикл
		Движение = Движения.Оценки.Добавить();
		Движение.Период = Дата;
		Движение.Предмет = Предмет;
		Движение.Студент = СтудентОценка.Студент;
		Движение.Оценка = СтудентОценка.Оценка;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти