--Isolde, Belle of the Underworld (anime)
function c511009043.initial_effect(c)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511009043.spcon)
	c:RegisterEffect(e2)
	--lv change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(2)
	e2:SetTarget(c511009043.lvtg)
	e2:SetOperation(c511009043.lvop)
	c:RegisterEffect(e2)
end
c511009043.listed_names={96163807}
function c511009043.spfilter(c)
	return c:IsFaceup() and c:IsCode(96163807)
end
function c511009043.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009043.spfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511009043.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsRace(RACE_ZOMBIE)
end
function c511009043.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009043.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511009043.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local lv=Duel.AnnounceLevel(tp,4,8,g:GetFirst():GetLevel())
	Duel.SetTargetParam(lv)
end
function c511009043.lvop(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
