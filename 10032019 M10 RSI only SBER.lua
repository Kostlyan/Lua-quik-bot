-- Что неоходимо сменить перед переходом из теста на бой: ACCOUNT, CLIENTCODE, CLASSCODE (в двух местах), DEPO_LIMIT

																			-- БЛОК ГЛОБАЛЬНЫХ ПЕРЕМЕННЫХ И СТРУКТУР ДАННЫХ
SETTINGS = {																-- Глобальная структура данных с настройками робота
	
	NETTRADER		= true,												-- Триггер нахождения на реальном рынке
	
	ACCOUNT 		= "L01+00000F00", 										-- Номер счёта в Джуниоре
	CLIENTCODE 		= "BP21755/01", 												-- Код клиента в Джуниоре
	--ACCOUNT 		= "NL0011100043", 										-- Номер счёта В Нэттрейдере
	--CLIENTCODE 	= "1948", 												-- Код клиента в Нэттрейдере
	FIRMID="MC0138200000",
	--FIRMID="NC0011100000",
	SECCODE 		= "SBER", 												-- Тикер
	
	--CLASSCODE 		= "QJSIM", 												-- Неведомое нечто в Джуниоре
	CLASSCODE 	= "TQBR", 												-- Неведомое нечто в Нэттрейдере

	RUN 			= true, 												-- Триггер выполнения программы
	TRADE			= true,												-- Триггер нахождения в рынке
	
	STARTHOUR 		= 10,													-- Время для начала работы алгоритма в часах (позже чем)
	STARTMIN 		= 01,													-- Время для начала работа алгоритма в минутах (позже чем)
	
	STOPHOUR		= 17,													-- Время для окончания работы алгоритма в часах (позже чем)
	STOPMIN			= 40,													-- Время для окончания работы алгоритма в минутах (позже чем)
	
	TRANS_ID 		= nil, 													-- Идентификатор транзакции подписывается временем в ОС
	TRANS_STATUS 	= nil, 													-- Числовой статус выполнения транзации
	TRANS_MSG 		= nil, 													-- Сообщение-статус выполнения транзации
	
	ORDER_ID 		= nil, 													-- Что?
	ORDER_PASSED 	= nil, 													-- Что-о-о???
	
	PRICE_STEP 		= 1, 													-- Значение пункта изменения цены
	QUANTITY 		= 6, 													-- Максимальное число лотов для покупки									
	SAFEZONE = 3,
	BUY_OR_SELL_ZONE=6,
	
	LOT 			= 5, 													-- Значение лота для тикера
	BID 			= nil, 													-- Количетсво лотов по лучшей цене в настоящий момент
	OFFER 			= nil,													-- Количетсво лотов по лучшей цене в настоящий момент
	LASTCLOSE		= nil,													-- Цена закрытия предыдущей свечи (для обновления порогов)

	ALGO_NAME 		= "M10-SBER-CENTURION", 									-- Имя алгоритма для записей в логах
	
	INTERVAL 		= INTERVAL_M10, 											-- Интервал графика
	ITERATOR 		= 1, 													-- Итератор для порционной покупки/продажи
	MULTIPLIER		= 10,													-- Множитель для определения количества акций в стоке: 1 для Джуниора и размер лота для Нэттрейдера
	SUM 			= 5000, 												-- Максимальная сумма единовременной покупки

	TRNSCTN_DELAY 	= 4, 													-- Задержка для выполнения транзакции в (TRNSCTN_DELAY - 1) секунд
	FAILSTOP 		= 500, 													-- Задержка в миллисекундах при ошибке
	DELAY 			= 900, 													-- Задержка в миллисекундах для обновления цен
	
	PRICE_LIMIT 	= 3, 													-- Допустимое количество пунктов при покупке дороже или продаже дешевле рынка
	
	TRADESCOUNT 	= 0, 													-- Сервисная переменная: количество сделок на момент запуска
	STOPLOSS 		= 100, 													-- Значение стоп-лосса в пунктах цены
	FORSTOPKOSTYL=1,
	
	SMA_NAME 		= "SMA_SBER", 											-- Название индикатора МА на графике
	PRICE_NAME 		= "PRICE_SBER", 										-- Название индикатора с ценой на графике
	STANDDEV_NAME = "STDEV_SBER",
	SMAFAST_NAME = "SMAFAST_SBER",
	SMANORMAL_NAME = "SMANORMAL_SBER",
	SMASLOW_NAME = "SMASLOW_SBER",
	RSI_NAME= "RSI_SBER",
	
	DEPO_LIMIT 		= "2"													-- Тип лимита в Джуниоре
	--DEPO_LIMIT 	= "0"													-- Тип лимита в Нэттрейдере
}

SECCODE 			= "SBER"
--CLASSCODE 			= "QJSIM"
CLASSCODE 		= "TQBR"
																			-- БЛОК ПОЛЬЗОВАТЕЛЬСКИХ ФУНКЦИЙ
function checkFlags(Flags, Bit)
	if type(Flags) ~= "number" then
		message("Wrong 'Flags' argument was passed into checkFlags!", 3)
	end
	if type(Bit) ~= "number" then 
		message("Wrong 'Bit' argument was passed into checkFlags!", 3)
	end

	if Bit == 0 then Bit = 0x1
		elseif Bit == 1 then Bit = 0x2
		elseif Bit == 2 then Bit = 0x4
		elseif Bit == 3 then Bit = 0x8
		elseif Bit == 4 then Bit = 0x10
		elseif Bit == 5 then Bit = 0x20
		elseif Bit == 6 then Bit = 0x40
		elseif Bit == 7 then Bit = 0x80
		elseif Bit == 8 then Bit = 0x100
		elseif Bit == 9 then Bit = 0x200
		elseif Bit == 10 then Bit = 0x400
		elseif Bit == 11 then Bit = 0x800
		elseif Bit == 12 then Bit = 0x1000
		elseif Bit == 13 then Bit = 0x2000
		elseif Bit == 14 then Bit = 0x4000
		elseif Bit == 15 then Bit = 0x8000
		elseif Bit == 16 then Bit = 0x10000
		elseif Bit == 17 then Bit = 0x20000
		elseif Bit == 18 then Bit = 0x40000
		elseif Bit == 19 then Bit = 0x80000
		elseif Bit == 20 then Bit = 0x100000
	end
 
	if bit.band(Flags, Bit) == Bit then 
		return true
	else 
		return false
	end
end		

function checkOrdersFlags(Flags, Bit)
	if type(Flags) ~= "number" then
		message("Wrong 'Flags' argument was passed into checkFlags!", 3)
	end
	if type(Bit) ~= "number" then 
		message("Wrong 'Bit' argument was passed into checkFlags!", 3)
	end

	if Bit == 0 then Bit = 0x1
		elseif Bit == 1 then Bit = 0x2
		elseif Bit == 2 then Bit = 0x4
		elseif Bit == 3 then Bit = 0x8
		elseif Bit == 4 then Bit = 0x10
		elseif Bit == 5 then Bit = 0x20
		elseif Bit == 6 then Bit = 0x40
		elseif Bit == 7 then Bit = 0x80
		elseif Bit == 8 then Bit = 0x100
		elseif Bit == 9 then Bit = 0x200
	end
 
	if bit.band(Flags, Bit) == Bit then 
		return true
	else 
		return false
	end
end																	

function checkStopFlags(Flags, Bit)
	if type(Flags) ~= "number" then
		message("Wrong 'Flags' argument was passed into checkFlags!", 3)
	end
	if type(Bit) ~= "number" then 
		message("Wrong 'Bit' argument was passed into checkFlags!", 3)
	end

	if Bit == 0 then Bit = 0x1
		elseif Bit == 1 then Bit = 0x2
		elseif Bit == 2 then Bit = 0x4
		elseif Bit == 3 then Bit = 0x8
		elseif Bit == 5 then Bit = 0x20
		elseif Bit == 6 then Bit = 0x40
		elseif Bit == 8 then Bit = 0x100
		elseif Bit == 9 then Bit = 0x200
		elseif Bit == 10 then Bit = 0x400
		elseif Bit == 11 then Bit = 0x800
		elseif Bit == 12 then Bit = 0x1000
		elseif Bit == 13 then Bit = 0x2000
		elseif Bit == 15 then Bit = 0x8000
	end
 
	if bit.band(Flags, Bit) == Bit then 
		return true
	else 
		return false
	end
end
																			
function checkOrder() 														-- Функция проверки выполнения выставленной заявки
	local StartTime = os.time()
	SETTINGS.ORDER_ID = nil
	
	while os.time() - StartTime < SETTINGS.TRNSCTN_DELAY do 				-- У заявки имеется (TRNSCTN_DELAY - 1) секунд на выполнение
		if SETTINGS.TRANS_STATUS == 3 then 									-- Если транзакция по выставлению заявки прошла успешно
			while SETTINGS.ORDER_ID == nil do
				for i = 0, getNumberOf("orders") - 1 do 					-- Идём по всему списку заявок
					local Order = getItem("orders", i)
					if Order.trans_id == SETTINGS.TRANS_ID then 			-- Находим заявку с нужным ID
						SETTINGS.ORDER_ID  = Order.order_num 				-- Сохраняем её номер
						if Order.balance == 0 then 							-- Проверяем, исполнена ли она
							SETTINGS.ORDER_PASSED = true 					-- Если да, то ставим соответствующий флаг
						else
							SETTINGS.ORDER_PASSED = false 					-- Если нет, то тоже ставим соответствующий флаг
						end
					end
				end
			end
		end
	end
	
	if SETTINGS.ORDER_PASSED ~= true then 									-- Если у заявки не обнаружен флаг полностью выполнившейся
		for i = 0, getNumberOf("orders") - 1 do 							-- Перебираем все заявки и ищем нужную, проверяем, активна ли она
			local Order = getItem("orders", i)
			if Order.trans_id == SETTINGS.TRANS_ID and Order.order_num == SETTINGS.ORDER_ID and checkFlags(Order.flags, 0) == true then
				local TRNSCTN_KILL = { 												-- Формируем структуру данных для снятия заявки
					TRANS_ID 		= tostring(SETTINGS.TRANS_ID),
					CLASSCODE 		= SETTINGS.CLASSCODE,
					SECCODE 		= SETTINGS.SECCODE,
					ACTION 			= "KILL_ORDER",
					ORDER_KEY 		= tostring(SETTINGS.ORDER_ID)
				}
		
				local Result = sendTransaction(TRNSCTN_KILL)						-- Снимаем заявку
				checkTransaction(Result) 											-- Проверяем, всё ли прошло успешно
				SETTINGS.ORDER_PASSED = nil 										-- Возвращаем флаг в исходное значение
				return false														-- Возвращаем false, если заявку пришлось отозвать
			end
		end 														
	end
	return true 															-- Возвращаем true, если заявка полностью прошла
end

function checkRealPrice()													-- Функция получения реальной цены покупки/продажи
	for i = 0, getNumberOf("trades") - 1 do
		local Trade = getItem("trades", i)
		if Trade.order_num == SETTINGS.ORDER_ID then
			return Trade.price
		end
	end
end

function checkTransaction(Reply) 											-- Функция проверки корректности выполнения sendTransaction()
	if Reply ~= '' then 													-- При успешном выполнении строка ответа пуста (не содержит ошибок)
		message("Something awkward happened while sending transaction!", 3)
		SETTINGS.TRADE = false
		SETTINGS.RUN = false
		return
	end
end

function Correlation_previous2(indicator1,indicator2)
    local sumtopfn	=0
	local sumbotf = 0
	local sumbotn = 0
	local Size = getNumCandles(indicator1)
	local sum10smafast=0
	local sum10smanormal=0
	local counter1=0
	local counter2=0
	for i = Size-2, Size-11, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
	    sum10smafast = sum10smafast + smafast
		counter1=counter1+1
	end
	avgsmafast = sum10smafast/counter1
	
	for i = Size-2, Size-11, - 1 do
	    local smanormal = getValueV2(indicator2, i, "close")
	    sum10smanormal = sum10smanormal + smanormal
		counter2=counter2+1
	end
	avgsmanormal = sum10smanormal/counter2
	
	for i = Size-2, Size-11, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
		local smanormal = getValueV2(indicator2, i, "close")
        local partcalculationsmafast = smafast - avgsmafast
		local partcalculationsmanormal = smanormal - avgsmanormal
		local partcalculationsfn = partcalculationsmafast*partcalculationsmanormal
		sumtopfn = sumtopfn +partcalculationsfn
	end	
	
	for i = Size-2, Size- 11, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
		local smanormal = getValueV2(indicator2, i, "close")
        local partcalculationsmafast = smafast - avgsmafast
		local partcalculationsmanormal = smanormal - avgsmanormal
		local doublepartcalculationsmafast =partcalculationsmafast*partcalculationsmafast
		local doublepartcalculationsmanormal = partcalculationsmanormal*partcalculationsmanormal
		sumbotf = sumbotf + doublepartcalculationsmafast
		sumbotn = sumbotn + doublepartcalculationsmanormal	
	end
	--korensumbotf = math.sqrt(sumbotf)
	--korensumbotn = math.sqrt(sumbotn)
	sumbot=math.sqrt(sumbotf*sumbotn)
	correlation_result=sumtopfn/sumbot
	return correlation_result
end

function Correlation_previous(indicator1,indicator2)
    local sumtopfn	=0
	local sumbotf = 0
	local sumbotn = 0
	local Size = getNumCandles(indicator1)
	local sum10smafast=0
	local sum10smanormal=0
	local counter1=0
	local counter2=0
	for i = Size-1, Size-10, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
	    sum10smafast = sum10smafast + smafast
		counter1=counter1+1
	end
	avgsmafast = sum10smafast/counter1
	
	for i = Size-1, Size-10, - 1 do
	    local smanormal = getValueV2(indicator2, i, "close")
	    sum10smanormal = sum10smanormal + smanormal
		counter2=counter2+1
	end
	avgsmanormal = sum10smanormal/counter2
	
	for i = Size-1, Size-10, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
		local smanormal = getValueV2(indicator2, i, "close")
        local partcalculationsmafast = smafast - avgsmafast
		local partcalculationsmanormal = smanormal - avgsmanormal
		local partcalculationsfn = partcalculationsmafast*partcalculationsmanormal
		sumtopfn = sumtopfn +partcalculationsfn
	end	
	
	for i = Size-1, Size- 10, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
		local smanormal = getValueV2(indicator2, i, "close")
        local partcalculationsmafast = smafast - avgsmafast
		local partcalculationsmanormal = smanormal - avgsmanormal
		local doublepartcalculationsmafast =partcalculationsmafast*partcalculationsmafast
		local doublepartcalculationsmanormal = partcalculationsmanormal*partcalculationsmanormal
		sumbotf = sumbotf + doublepartcalculationsmafast
		sumbotn = sumbotn + doublepartcalculationsmanormal	
	end
	--korensumbotf = math.sqrt(sumbotf)
	--korensumbotn = math.sqrt(sumbotn)
	sumbot=math.sqrt(sumbotf*sumbotn)
	correlation_result=sumtopfn/sumbot
	return correlation_result
end

function Correlation(indicator1,indicator2)
    local sumtopfn	=0
	local sumbotf = 0
	local sumbotn = 0
	local Size = getNumCandles(indicator1)
	local sum10smafast=0
	local sum10smanormal=0
	local counter1=0
	local counter2=0
	for i = Size, Size-9, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
	    sum10smafast = sum10smafast + smafast
		counter1=counter1+1
	end
	avgsmafast = sum10smafast/counter1
	
	for i = Size, Size-9, - 1 do
	    local smanormal = getValueV2(indicator2, i, "close")
	    sum10smanormal = sum10smanormal + smanormal
		counter2=counter2+1
	end
	avgsmanormal = sum10smanormal/counter2
	
	for i = Size, Size-9, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
		local smanormal = getValueV2(indicator2, i, "close")
        local partcalculationsmafast = smafast - avgsmafast
		local partcalculationsmanormal = smanormal - avgsmanormal
		local partcalculationsfn = partcalculationsmafast*partcalculationsmanormal
		sumtopfn = sumtopfn +partcalculationsfn
	end	
	
	for i = Size, Size- 9, - 1 do
	    local smafast = getValueV2(indicator1, i, "close")
		local smanormal = getValueV2(indicator2, i, "close")
        local partcalculationsmafast = smafast - avgsmafast
		local partcalculationsmanormal = smanormal - avgsmanormal
		local doublepartcalculationsmafast =partcalculationsmafast*partcalculationsmafast
		local doublepartcalculationsmanormal = partcalculationsmanormal*partcalculationsmanormal
		sumbotf = sumbotf + doublepartcalculationsmafast
		sumbotn = sumbotn + doublepartcalculationsmanormal	
	end
	--korensumbotf = math.sqrt(sumbotf)
	--korensumbotn = math.sqrt(sumbotn)
	sumbot=math.sqrt(sumbotf*sumbotn)
	correlation_result=sumtopfn/sumbot
	return correlation_result
end

-- math.sqrt

function countActiveStopOrders()
	local Counter = 0
	for i = 0, getNumberOf("stop_orders") - 1 do
		local StopOrder = getItem("stop_orders", i)
		if checkFlags(tonumber(StopOrder.flags), 0) == true and tostring(StopOrder.sec_code) == SETTINGS.SECCODE then
			Counter = Counter + 1
		end
	end
	return Counter
end

function countIterator() 													-- Функция подсчёта количества лотов при заданном капитале 			TODO: Добавить bid и offer
																			-- Устанавливает необходимое количество покупок для заданного объёма
	local Quantity = 0
	local Trash = 0
	local Price = getParamEx(SETTINGS.CLASSCODE, SETTINGS.SECCODE, "offer").param_value 			-- Берём текущую цену предложения
	Quantity, Trash = math.modf(math.floor(SETTINGS.SUM / Price) / SETTINGS.LOT) * SETTINGS.LOT 	-- Вычисляем объём покупки, кратный лоту
			
	SETTINGS.ITERATOR = Quantity / SETTINGS.LOT 							-- Считаем, сколько лотов придётся купить/продать для заданного объёма
end

function countPrice(														-- Функция получения лучшей ценв спроса или предложения в стакане
Type)																		-- Тип: цена предложения или цена спроса, "offer" или "bid"
																			-- Получает реальную рыночную цену и прибавляет к ней установленный допуск по потерям в пунктах
																			-- Пример: countPrice("offer")
	local Limit = SETTINGS.PRICE_LIMIT * SETTINGS.PRICE_STEP
	
	if Type == "offer" then
		local Price = getParamEx(SETTINGS.CLASSCODE, SETTINGS.SECCODE, "offer").param_value
		return Price + Limit
	elseif Type == "bid" then
		local Price = getParamEx(SETTINGS.CLASSCODE, SETTINGS.SECCODE, "bid").param_value
		return Price - Limit
	else
		message("Wrong 'Type' argument was passed into countPrice!", 3)
		SETTINGS.RUN = false
		return
	end
end

function cutSign(Negative)													-- Функция, возвращающая модуль числа
																			-- Принимает на вход число и возвращает число
	local Positive = math.abs(Negative)
	return Positive
end

function cutTwoDigits(LongPrice)											-- Функция для отрезания лишних знаков после запятой
																			-- Принимает на вход число, а возвращает строку
	local Left, Right = math.modf(LongPrice) 								-- Отделяем части числа: целую (Left) и дробную (Right)
	Right = tostring(Right) 												-- Конвертируем дробную часть в строку, принимает вид: 0.NN...N
	Right = string.sub(Right,1,4) 											-- Отрезаем первые два числа дробной части после запятой, принимает вид: 0.NN
	local Result = tostring(Left + tonumber(Right))							-- Конвертируем обработанную дробную часть в число, складываем с целой частью и конвертируем в строку
	return Result
end

function getAveragePrice() 													-- Функция получения средней цены лотов в стоке
	for i = 0, getNumberOf("depo_limits") - 1 do
		local DepoLimit = getItem("depo_limits", i)
		if tostring(DepoLimit.sec_code) == SETTINGS.SECCODE and tostring(DepoLimit.trdaccid) == SETTINGS.ACCOUNT and tostring(DepoLimit.limit_kind) == SETTINGS.DEPO_LIMIT then
			return tonumber(DepoLimit.awg_position_price)
		end
	end
end

function getStopPrice() 													-- Функция получения средней цены лотов в стоке
	for i = 0, getNumberOf("stop_orders") - 1 do
		local StopOrders = getItem("stop_orders", i)
		if tostring(StopOrders.sec_code) == SETTINGS.SECCODE and checkStopFlags(StopOrders.flags, 0) == true  then
			return tonumber(StopOrders.condition_price)
		end
	end
end

function getTime()
	return os.date("*t")
end

function getQuantity()														-- Функция получения количества лотов в стоке
	for i = 0, getNumberOf("depo_limits") - 1 do
		local DepoLimit = getItem("depo_limits", i)
		if tostring(DepoLimit.sec_code) == SETTINGS.SECCODE and tostring(DepoLimit.trdaccid) == SETTINGS.ACCOUNT and tostring(DepoLimit.limit_kind) == SETTINGS.DEPO_LIMIT then
			return tonumber(DepoLimit.currentbal)
		end
	end
end

function getValue(															-- Функция получения значения из любого* индикатора
Indicator, 																	-- Название индикатора на графике: "SMA_SBER"
Position, 																	-- Позиция свечи: текущая или предыдущая
Type) 																		-- Тип: по открытию или по закрытию
																			-- Пример: getValue("SMA_SBER", "current", "close")
	local Size = getNumCandles(Indicator)
	
	if Size == nil then
		message(tostring(Indicator).." is somehow empty!", 3)
		SETTINGS.TRADE = false
		SETTINGS.RUN = false
		return
	end
	
	local t, n, l
	t, n, l = getCandlesByIndex (Indicator, 0, 0, Size)
	
	if Position == "current" then
		if Type == "open" then
			return t[Size - 1].open
		elseif Type == "close" then
			return t[Size - 1].close
		else
			message("Wrong 'Type' argument was passed into getValue!", 3)
			SETTINGS.TRADE = false
			SETTINGS.RUN = false
			return
		end
	elseif Position == "previous" then
		if Type == "open" then
			return t[Size - 2].open
		elseif Type == "close" then
			return t[Size - 2].close
		else
			message("Wrong 'Type' argument was passed into getValue!", 3)
			SETTINGS.TRADE = false
			SETTINGS.RUN = false
			return
		end
	else
		message("Wrong 'Position' argument was passed into getValue!", 3)
		SETTINGS.TRADE = false
		SETTINGS.RUN = false
		return
	end
end

function getValueV2(															-- Функция получения значения из любого* индикатора
Indicator, 																	-- Название индикатора на графике: "SMA_SBER"
Position, 																	-- Позиция свечи: текущая или предыдущая
Type) 																		-- Тип: по открытию или по закрытию
																			-- Пример: getValue("SMA_SBER", "current", "close")
	local Size = getNumCandles(Indicator)
	
	if Size == nil then
		message(tostring(Indicator).." is somehow empty!", 3)
		SETTINGS.TRADE = false
		SETTINGS.RUN = false
		return
	end
	
	local t, n, l
	t, n, l = getCandlesByIndex (Indicator, 0, 0, Size)
	
	if Position == "current" then
		if Type == "open" then
			return t[Size - 2].open
		elseif Type == "close" then
			return t[Size - 2].close
		else
			message("Wrong 'Type' argument was passed into getValue!", 3)
			SETTINGS.TRADE = false
			SETTINGS.RUN = false
			return
		end
	elseif Position == "previous" then
		if Type == "open" then
			return t[Size - 3].open
		elseif Type == "close" then
			return t[Size - 3].close
		else
			message("Wrong 'Type' argument was passed into getValue!", 3)
			SETTINGS.TRADE = false
			SETTINGS.RUN = false
			return
		end
	else
	    if Type == "open" then
			return t[Position-1].open
		elseif Type == "close" then
			return t[Position-1].close
		else
			message("Wrong 'Type' argument was passed into getValue!", 3)
			SETTINGS.TRADE = false
			SETTINGS.RUN = false
			return
		end
	end
end

function killActiveStopOrders()
	for i = 0, getNumberOf("stop_orders") - 1 do
		local StopOrder = getItem("stop_orders", i)
		if checkFlags(tonumber(StopOrder.flags), 0) == true and tostring(StopOrder.sec_code) == SETTINGS.SECCODE then
			SETTINGS.TRANS_ID = os.time()
			local TRNSCTN_KILL_STOP = {
				ACTION              = "KILL_STOP_ORDER",
				TRANS_ID            = tostring(SETTINGS.TRANS_ID),
				CLASSCODE           = SETTINGS.CLASSCODE,
				SECCODE             = SETTINGS.SECCODE,
				STOP_ORDER_KEY     	= tostring(StopOrder.order_num),
			}
			sendTransaction(TRNSCTN_KILL_STOP)
		end
	end
end

function killActiveOrders()
	for i = 0, getNumberOf("orders") - 1 do
		local Order = getItem("orders", i)
		if checkOrdersFlags(tonumber(Order.flags), 0) == true and tostring(Order.sec_code) == SETTINGS.SECCODE then
			SETTINGS.TRANS_ID = os.time()
			SETTINGS.ORDER_ID = Order.order_num
			local TRNSCTN_KILL = { 												-- Формируем структуру данных для снятия заявки
					TRANS_ID 		= tostring(SETTINGS.TRANS_ID),
					CLASSCODE 		= SETTINGS.CLASSCODE,
					SECCODE 		= SETTINGS.SECCODE,
					ACTION 			= "KILL_ORDER",
					ORDER_KEY 		= tostring(SETTINGS.ORDER_ID)
				}
	            sendTransaction(TRNSCTN_KILL)						-- Снимаем заявку
		end
	end
end

function makeADeal(T, O, P, Q)												-- Функция совершения транзакции с проверкой исполнения
																			-- Пример: makeADeal("M", "B", "0", "3") - купить 3 лота по рынку
																			-- Пример: makeADeal("L", "S", "132", "5") - продать 5 лотов лимитной заявкой по 132
	local Type = tostring(T)
	local Operation = tostring(O)
	local Price = tostring(P)
	local Quantity = tostring(Q)
	
	if Type == "M" then 													-- Если заявка по рынку, цена должна быть "0"
		Price = "0"
	end
	
	if Type == "L" then 																	-- Если заявка лимитная
		Quantity = tonumber(Quantity)
		if Operation == "B" then 															-- И если планируется покупка
			if Quantity > SETTINGS.OFFER then 												-- И если по данной цене в стоке нет нужного количества лотов
				message("Offer of "..tostring(SETTINGS.SECCODE).." is too small for the quantity given, aborting!", 2)
				return false 																-- Отказываемся от затеи
			end
		elseif Operation == "S" then														-- Или если планируется продажа
			if Quantity > SETTINGS.BID then 												-- И если по данной цене в стоке нет нужного количества лотов
				message("Bid of "..tostring(SETTINGS.SECCODE).." is too small for the quantity given, aborting!", 2)
				return false 																-- Отказываемся от затеи
			end
		end
		Quantity = tostring(Quantity)
	end
	
	SETTINGS.TRANS_ID = os.time()
	local TRNSCTN = {
		ACCOUNT 	= SETTINGS.ACCOUNT,
		CLIENT_CODE = SETTINGS.CLIENTCODE,
		TYPE 		= Type,
		TRANS_ID 	= tostring(SETTINGS.TRANS_ID),
		CLASSCODE 	= SETTINGS.CLASSCODE,
		SECCODE 	= SETTINGS.SECCODE,
		ACTION 		= "NEW_ORDER",
		OPERATION 	= Operation,
		PRICE 		= Price,
		QUANTITY 	= Quantity,
		COMMENT		= tostring(SETTINGS.ALGO_NAME)
	}
	
	local Reply = sendTransaction(TRNSCTN)
	checkTransaction(Reply)
	
	while SETTINGS.TRANS_STATUS == nil do
		sleep(1)
	end
	
	local TransResult
	TransResult = checkOrder()
	if TransResult == true then
		if Operation == "B" then
			message("Managed to buy "..tostring(Quantity).." of "..tostring(SETTINGS.SECCODE)..", overall quantity is "..tostring(getQuantity()), 2)
		elseif Operation == "S" then
			message("Managed to sell "..tostring(Quantity).." of "..tostring(SETTINGS.SECCODE)..", overall quantity is "..tostring(getQuantity()), 2)
		else
			message("Was unable to determine if bought or sold!", 3)
			SETTINGS.TRADE = false
			SETTINGS.RUN = false
			return false
		end
	else
		message("Was unable to buy or sell "..tostring(Quantity).." of "..tostring(SETTINGS.SECCODE), 3)
		return false
	end
	
	SETTINGS.TRANS_ID = nil
	return true
end

function placeAverageStopOrders(Direction)
	killActiveStopOrders()												-- Снять все активные стоп-заявки						
	
	Price = cutTwoDigits(getAveragePrice())								-- Цена стопа будет откладываться от средней цены портфеля
	Quantity = cutSign(getQuantity()) / SETTINGS.MULTIPLIER				-- Количество: все лоты в портфеле
	
	local StopLossPrice
	if Direction == "long" then
		StopLossPrice = tonumber(Price) - SETTINGS.STOPLOSS * SETTINGS.PRICE_STEP
	elseif Direction == "short" then
		StopLossPrice = tonumber(Price) + SETTINGS.STOPLOSS * SETTINGS.PRICE_STEP
	end
	
	local StopLossOperation
	if Direction == "long" then
		StopLossOperation = "S"
	elseif Direction == "short" then
		StopLossOperation = "B"
	end
	
	SETTINGS.TRANS_ID = os.time()
	local TRNSCTN_STOP = {
        ACTION              = "NEW_STOP_ORDER",
		TRANS_ID            = tostring(SETTINGS.TRANS_ID),
		CLASSCODE           = SETTINGS.CLASSCODE,
		SECCODE             = SETTINGS.SECCODE,
		ACCOUNT             = SETTINGS.ACCOUNT,
		TYPE				= Type,
		OPERATION           = StopLossOperation,
		QUANTITY            = tostring(Quantity),
		PRICE               = tostring(StopLossPrice),
		STOP_ORDER_KIND     = "SIMPLE_STOP_ORDER",
		EXPIRY_DATE         = "TODAY",
		STOPPRICE          	= tostring(StopLossPrice)
	}
	
	StopReply = sendTransaction(TRNSCTN_STOP)
	
	SETTINGS.TRANS_ID = nil
	return true
end

function placeAverageStopOrdersTrail(Direction,SPREADZONE)
	killActiveStopOrders()												-- Снять все активные стоп-заявки						
	
	Price = cutTwoDigits(getAveragePrice())								-- Цена стопа будет откладываться от средней цены портфеля
	Quantity = cutSign(getQuantity()) / SETTINGS.MULTIPLIER				-- Количество: все лоты в портфеле
	
	
	local StopLossPrice
	if Direction == "long" then
		StopLossPrice = tonumber(Price) + SPREADZONE 
	elseif Direction == "short" then
		StopLossPrice = tonumber(Price) - SPREADZONE 
	end
	
	local StopLossOperation
	if Direction == "long" then
		StopLossOperation = "S"
	elseif Direction == "short" then
		StopLossOperation = "B"
	end
	
	SETTINGS.TRANS_ID = os.time()
	local TRNSCTN_STOP = {
        ACTION              = "NEW_STOP_ORDER",
		TRANS_ID            = tostring(SETTINGS.TRANS_ID),
		CLASSCODE           = SETTINGS.CLASSCODE,
		SECCODE             = SETTINGS.SECCODE,
		ACCOUNT             = SETTINGS.ACCOUNT,
		TYPE				= Type,
		OPERATION           = StopLossOperation,
		QUANTITY            = tostring(Quantity),
		PRICE               = tostring(StopLossPrice),
		STOP_ORDER_KIND     = "SIMPLE_STOP_ORDER",
		EXPIRY_DATE         = "TODAY",
		STOPPRICE          	= tostring(StopLossPrice)
	}
	
	StopReply = sendTransaction(TRNSCTN_STOP)
	
	SETTINGS.TRANS_ID = nil
	return true
end
																			-- БЛОК CALLBACK-ФУНКЦИЙ

function OnInit() 															-- Функция выполняется однократно перед запуском функции main()
	if SETTINGS.NETTRADER == true then										-- Если торгуем в Нэттрейдере, потребуется изменить некоторые значения
		SETTINGS.ACCOUNT = "L01+00000F00"
		SETTINGS.CLIENTCODE = "BP21755/01"
		SETTINGS.CLASSCODE = "TQBR"
		CLASSCODE = "TQBR"
		SETTINGS.DEPO_LIMIT = "2"
	end
	
	local Error = ''
	DataSource, Error = CreateDataSource(SETTINGS.CLASSCODE, SETTINGS.SECCODE, SETTINGS.INTERVAL) 				-- Грузим все данные по тикеру и заданному интервалу
	
	--file = io.open("C:\\Users\\InfiniteSuns\\Documents\\QUIK Lua Scripts\\trade.log", "a")
	--file:write(tostring(os.date()).." "..SETTINGS.ALGO_NAME.." is initiating".."\n")
	--file:close()
	
	local Info = getSecurityInfo(SETTINGS.CLASSCODE, SETTINGS.SECCODE) 											-- Получаем всю информацию по тикеру
	SETTINGS.PRICE_STEP = getParamEx(SETTINGS.CLASSCODE, SETTINGS.SECCODE, "SEC_PRICE_STEP").param_value 		-- Получаем значение пункта для данного тикера
	SETTINGS.LOT = Info.lot_size 																				-- Записываем в структуру с настройками значение лота для тикера
	
	if SETTINGS.NETTRADER == true then																			-- Если торгуем в Нэттрейдере, потребуется изменить некоторые значения
		SETTINGS.MULTIPLIER = tonumber(SETTINGS.LOT)															-- Множитель компенсирует то, что в Нэттрейдере в потрфеле акции, а в Джуниоре лоты
	end
	
	if DataSource == nil then 												-- Если вдруг ничего не загрузилось, паникуем
		message('Can\'t reach candles: '..Error, 3)
		SETTINGS.TRADE = false
		SETTINGS.RUN = false
		return
	end
	
	Quotes = getQuoteLevel2(SETTINGS.CLASSCODE, SETTINGS.SECCODE)
	
	SETTINGS.OFFER = 0
	SETTINGS.BID = 0
	
	for i = tonumber(Quotes.bid_count), 1, -1 do
		if Quotes.bid[i].quantity ~= nil then   							-- На некоторых ценах могут отсутствовать заявки
			if tonumber(Quotes.bid[i].price) >= countPrice("bid") then
				SETTINGS.BID = SETTINGS.BID + tonumber(Quotes.bid[i].quantity)
			end
		end
	end

	for i = 1, tonumber(Quotes.offer_count), 1 do
		if Quotes.offer[i].quantity ~= nil then   							-- На некоторых ценах могут отсутствовать заявки
			if tonumber(Quotes.offer[i].price) <= countPrice("offer") then
				SETTINGS.OFFER = SETTINGS.OFFER + tonumber(Quotes.offer[i].quantity)
			end
		end
	end
	
	if SETTINGS.OFFER == nil or SETTINGS.BID == nil then
		message('Can\'t get '..tostring(SETTINGS.SECCODE)..'\'s offer or bid', 3)
	end
	
	SETTINGS.TRADESCOUNT = getNumberOf("trades")
end

function OnStop()															-- Функция выполняется однократно при остановке выполнения программы
	SETTINGS.TRADE = false
	SETTINGS.RUN = false
	
	--file = io.open("C:\\Users\\InfiniteSuns\\Documents\\QUIK Lua Scripts\\trade.log", "a")
	--file:write(tostring(os.date()).." "..SETTINGS.ALGO_NAME.." is shutting down".."\n")
	--file:close()
end

function OnTrade(Trade)
	local TradesCount = getNumberOf("trades")
	
	if TradesCount ~= SETTINGS.TRADESCOUNT then
		SETTINGS.TRADESCOUNT = TradesCount
	end
end

function OnDisconnected()
	message("Disconnect detected, aborting!", 3)
	SETTINGS.TRADE = false
end

function OnConnected()
	message("Connect detected, resuming!", 2)
	SETTINGS.TRADE = true
end

function OnTransReply(TransReply) 											-- Коллбэк-функция, отрабатывает при выставлении заявки алгоритмом
	if TransReply.trans_id == SETTINGS.TRANS_ID then 						-- Если идентификатор транзации совпадает с таковым у последней транзации алгоритма
		SETTINGS.TRANS_STATUS = TransReply.status 							-- Сохраняем в глобальную переменную статус-код
		SETTINGS.TRANS_MSG = TransReply.result_msg 							-- Сохраняем в глобальную переменную сообщение-статус
	end
end

function OnQuote(CLASSCODE, SECCODE)										-- Коллбэк-функция, отрабатывает при изменении стакана
																			-- При каждом изменении стакана сохраняет в глобальные переменные...
																			-- ...количество лотов по лучшей цене покупки и продажи
	Quotes = getQuoteLevel2(SETTINGS.CLASSCODE, SETTINGS.SECCODE)
	
	SETTINGS.BID = 0
	for i = tonumber(Quotes.bid_count), 1, -1 do
		if Quotes.bid[i].quantity ~= nil then   							-- На некоторых ценах могут отсутствовать заявки
			if tonumber(Quotes.bid[i].price) >= countPrice("bid") then
				SETTINGS.BID = SETTINGS.BID + tonumber(Quotes.bid[i].quantity)
			end
		end
	end
	SETTINGS.OFFER = 0
	for i = 1, tonumber(Quotes.offer_count), 1 do
		if Quotes.offer[i].quantity ~= nil then   							-- На некоторых ценах могут отсутствовать заявки
			if tonumber(Quotes.offer[i].price) <= countPrice("offer") then
				SETTINGS.OFFER = SETTINGS.OFFER + tonumber(Quotes.offer[i].quantity)
			end
		end
	end
	return
end

function main()
	while SETTINGS.RUN do													-- Триггер выполнения программы	
		while SETTINGS.TRADE do		
	
		
			local RSI_Current = getValueV2(SETTINGS.RSI_NAME, "current", "close")
			local RSI_Previous = getValueV2(SETTINGS.RSI_NAME, "previous", "close")
            local Size = getNumCandles(SETTINGS.PRICE_NAME) 			
			local ClosePrevious = getValueV2(SETTINGS.PRICE_NAME, "previous", "close")
			local OpenPrevious = getValueV2(SETTINGS.PRICE_NAME, "previous", "open")
			local OpenCurrent = getValueV2(SETTINGS.PRICE_NAME, "current", "open")
			local OpenCurrent_with_safezone_long = OpenCurrent + SETTINGS.SAFEZONE*SETTINGS.PRICE_STEP
			local OpenCurrent_with_safezone_short = OpenCurrent - SETTINGS.SAFEZONE*SETTINGS.PRICE_STEP
			local CloseCurrent = getValueV2(SETTINGS.PRICE_NAME, "current", "close")
			local OfferPrice = countPrice("offer")
			local BidPrice = countPrice("bid")
			local portfolio_long = getPortfolioInfo(SETTINGS.FIRMID, SETTINGS.CLIENTCODE).val_long
			local longcondition = tonumber(portfolio_long)+100000
			
				--message(tostring(RSI_Current), 2)
			--local StDeviation=getValue(SETTINGS.STANDDEV_NAME, "current", "close")
			--local Fastsmapv = getValue(SETTINGS.SMAFAST_NAME, "previous", "close")
			--local Fastsma = getValue(SETTINGS.SMAFAST_NAME, "current", "close")
			--local Fastsmapv_open = getValue(SETTINGS.SMAFAST_NAME, "previous", "open")
			--local Normalsmapv = getValue(SETTINGS.SMANORMAL_NAME, "previous", "close")
			--local Normalsmapv_open = getValue(SETTINGS.SMANORMAL_NAME, "previous", "open")
	        local Time = getTime()
			--message(tostring(Time), 2)
			--SETTINGS.SAFEZONE=StDeviation/SETTINGS.PRICE_STEP/2
			--SETTINGS.STOPLOSS=(cutTwoDigits(StDeviation))/SETTINGS.PRICE_STEP

			if  RSI_Current >48.125 and RSI_Previous <48.125 then                  --vhod v long
			    if getQuantity() >= 0 and cutSign(getQuantity()/ SETTINGS.MULTIPLIER ) < SETTINGS.QUANTITY then														
					killActiveOrders()
					local Odds = SETTINGS.QUANTITY - cutSign(getQuantity()) / SETTINGS.MULTIPLIER 										
					local Status = makeADeal("L", "B", tostring(OfferPrice), tostring(cutSign(Odds)))											
					if Status ~= true then
						sleep(SETTINGS.FAILSTOP)
					end
					killActiveStopOrders()
						--placeAverageStopOrders("long")
				end
			end
			
			if  RSI_Current <84.7 and RSI_Previous >84.7  then  --vyhod iz longa
			    if getQuantity() > 0 then																								
					killActiveOrders()
					local Status = makeADeal("L", "S", tostring(BidPrice), tostring(cutSign(getQuantity()/ SETTINGS.MULTIPLIER )))								
					if Status ~= true then
						sleep(SETTINGS.FAILSTOP)
					end
					killActiveStopOrders()
			    end
			end
			
			if  RSI_Current <55.625 and RSI_Previous >55.625  then  --vyhod iz longa
			    if getQuantity() > 0 then																								
					killActiveOrders()
					local Status = makeADeal("L", "S", tostring(BidPrice), tostring(cutSign(getQuantity()/ SETTINGS.MULTIPLIER )))								
					if Status ~= true then
						sleep(SETTINGS.FAILSTOP)
					end
					killActiveStopOrders()
			    end
			end
			
			if  RSI_Current >21.04 and RSI_Previous <21.04  then                  --vyhod is shorta
			    if getQuantity() < 0  then														
					killActiveOrders()
					local Odds = cutSign(getQuantity()) / SETTINGS.MULTIPLIER 										
					local Status = makeADeal("L", "B", tostring(OfferPrice), tostring(cutSign(Odds)))											
					if Status ~= true then
						sleep(SETTINGS.FAILSTOP)
					end
					killActiveStopOrders()
						--placeAverageStopOrders("long")
				end
			end
			
			if  RSI_Current >48.125 and RSI_Previous <48.125  then                  --vyhod is shorta
			    if getQuantity() < 0  then														
					killActiveOrders()
					local Odds = cutSign(getQuantity()) / SETTINGS.MULTIPLIER 										
					local Status = makeADeal("L", "B", tostring(OfferPrice), tostring(cutSign(Odds)))											
					if Status ~= true then
						sleep(SETTINGS.FAILSTOP)
					end
					killActiveStopOrders()
						--placeAverageStopOrders("long")
				end
			end
			
			
			if  RSI_Current <55.625 and RSI_Previous >55.625  then  --vhod v short
			    if getQuantity() <= 0 and cutSign(getQuantity()/ SETTINGS.MULTIPLIER ) < SETTINGS.QUANTITY then																								
					killActiveOrders()
					local Status = makeADeal("L", "S", tostring(BidPrice), tostring( SETTINGS.QUANTITY - cutSign(getQuantity()) / SETTINGS.MULTIPLIER ))								
					if Status ~= true then
						sleep(SETTINGS.FAILSTOP)
					end
					killActiveStopOrders()
			    end
			end
			sleep(SETTINGS.DELAY)
		
		end																	-- Концец while по TRADE
	end 	-- Концец while по RUN	
end 																		-- Конец цикла main