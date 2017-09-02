RAKOMETR.SPELLTABLE = {

	-- Шаблон:
	--[[
	
	['Имя спела'] = -- спелл, можно указывать ID(без ковычек)
	{
	
		dmgtype = 'hit',-- Тип урона, если лужа/переодический урон пишем 'dot;n;t' где t = сколько секунд допустимо простоять в луже, n - сколько раз тикнуло по игроку.
						-- 'hit' - единичный удар
						
		frendlyfire = false, -- Урон по союзникам(в разработке, пока что оставляем false)
		encounter = 'In Zone', -- Описание
		role = 'TANK;DAMAGER;HEALER' -- Роль для которой данный спел актуален(допустим словить дыхание в ебало актуально только для дд и хилов, но не для танка, тогда будет так: 'DAMAGER;HEALER'.
	
	},
	]]
	-- Миф +
	['Вулканический шлейф'] = {dmgtype = 'hit', frendlyfire = false, encounter = 'In Zone', role = 'TANK;DAMAGER;HEALER'},
	
	-- ИК
		
		-- Низендра
		[203646] = {dmgtype = 'hit', frendlyfire = false, encounter = 'Низендра(жуки)', role = 'TANK;DAMAGER;HEALER'},
		['Заразное дыхание'] = {dmgtype = 'hit', frendlyfire = false, encounter = 'Низендра(дыхание)', role = 'TANK;DAMAGER;HEALER'}, 
		--Ил'гинот, Сердце Порчи
		['Око судьбы'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Ил'гинот(стоял перед лицом адда)", role = 'DAMAGER;HEALER'},
		--Драконы
		--['Дремотный кошмар'] = {encounter = "Драконы кошмара(10й стак)", role = 'TANK;DAMAGER;HEALER'},
			--Таэрар
			['Сочащийся туман'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Таэрар(сон)", role = 'TANK;DAMAGER;HEALER'},
	
	-- 5ppl
	
		-- Логово нелтариона
		
			--Уларогг 
			['Удар горы'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Уларогг(каменные руки)", role = 'TANK;DAMAGER;HEALER'},
			--Даргрул
			['Магматическая волна'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Даргрул(не убежал за стену)", role = 'DAMAGER;HEALER'},
			
		-- Око азщары
			
			--Треш
			[195217] = {dmgtype = 'hit', frendlyfire = false, encounter = "Треш", role = 'TANK;DAMAGER;HEALER'},
			[195473] = {dmgtype = 'hit', frendlyfire = false, encounter = "Треш", role = 'DAMAGER;HEALER'},
			['Бурлящая буря'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Треш", role = 'TANK;DAMAGER;HEALER'},
			
			--Паржеш
			[191977] = {dmgtype = 'hit', frendlyfire = false, encounter = "Паржеш(Копье, не забежал за моба)", role = 'TANK;DAMAGER;HEALER'},
			['Сокрушительная волна'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Паржеш(волна, не отбежал)", role = 'DAMAGER;HEALER'},
			--Леди
			[193597] = {dmgtype = 'hit', frendlyfire = false, encounter = "Леди(не забежал на песок)", role = 'TANK;DAMAGER;HEALER'},
			--Волнобород
			['Взрыв газа'] = {dmgtype = 'hit', frendlyfire = true, encounter = "Волнобород(не сбил пузырь газа)", role = 'TANK;DAMAGER;HEALER'},
			--Гнев азшары
			['Приливная волна'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Гнев азшары(попал в волну)", role = 'TANK;DAMAGER;HEALER'},
			
			[192794] = {dmgtype = 'hit', frendlyfire = false, encounter = "Гнев азшары(молния)", role = 'TANK;DAMAGER;HEALER'},
			
			['Волщебный торнадо'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Гнев азшары(молния)", role = 'TANK;DAMAGER;HEALER'},
			['Потоп'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Гнев азшары(не выбежал)", role = 'TANK;DAMAGER;HEALER'},
			
		-- Утроба душ
		
			--Имирон
			['Крики мертвых'] = {dmgtype = 'aura', frendlyfire = false, encounter = "Имирон(не выбежал)", role = 'TANK;DAMAGER;HEALER'},
			['Погибель'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Имирон(вращающиеся круги на земле)", role = 'TANK;DAMAGER;HEALER'},
			--Харбарон
			['Космическая коса'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Харбарон(не отбежал)", role = 'TANK;DAMAGER;HEALER'},
			--Хелия
			['Сущность порчи'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Хелия(не выбежал из лужи)", role = 'TANK;DAMAGER;HEALER'},
			['Обстрел солоноватой водой'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Хелия(не отбежал)", role = 'TANK;DAMAGER;HEALER'},
			
		-- Чаща
		
			--Треш
			['Звездный дождь'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Треш", role = 'DAMAGER;HEALER'},
			
			--Верховный друид
			['Первобытная ярость'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Верховный друид(стоял у лица)", role = 'DAMAGER;HEALER'},
			--Дубосерд
			['Дыхание кошмара'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Дубосерд(стоял у лица)", role = 'DAMAGER;HEALER'},
			--Ксавий
			['Апокалиптический огонь'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Ксавий(красные лужи)", role = 'DAMAGER;HEALER'},
			
		-- Чертоги
			
			--Химдаль
			['Статическое поле'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Химдаль(драконы)", role = 'TANK;DAMAGER;HEALER'},
			['Кровопролитный круговой удар'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Химдаль(стоял у лица)", role = 'DAMAGER;HEALER'},
			--Хирья
			['Щит света'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Хирья(стоял у лица)", role = 'DAMAGER;HEALER'},
			--['Освящение'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Хирья(Освящение)", role = 'TANK;DAMAGER;HEALER'},
			
			--Один
			['Копье света'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Один(копье)", role = 'TANK;DAMAGER;HEALER'},
			['Сияющий фрагмент'] = {dmgtype = 'hit', frendlyfire = false, encounter = "Один(искры)", role = 'TANK;DAMAGER;HEALER'},
}