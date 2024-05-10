Процедура ПроверитьОценкуСтудентов(ЭтотОбъект, Оценки, Отказ) Экспорт
	МаксимальнаяОценка = Константы.МаксимальнаяОценкаСтудента.Получить();

	Для Каждого СтудентОценка Из Оценки Цикл
		Если СтудентОценка.Оценка > МаксимальнаяОценка Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = СтрШаблон(
				"Студент ""%1"" имеет оценку больше максимальной!", СтудентОценка.Студент);
			Сообщение.Поле = СтрШаблон("Оценки[%1].Оценка", СтудентОценка.НомерСтроки - 1);
			Сообщение.УстановитьДанные(ЭтотОбъект);
			Сообщение.Сообщить();
			Отказ = Истина;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры