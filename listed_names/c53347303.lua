--青眼の光龍
function c53347303.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c53347303.spcon)
	e2:SetOperation(c53347303.spop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c53347303.val)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(53347303,0))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c53347303.discon)
	e4:SetTarget(c53347303.distg)
	e4:SetOperation(c53347303.disop)
	c:RegisterEffect(e4)
	--Double Snare
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(3682106)
	c:RegisterEffect(e5)
end
c53347303.listed_names={23995346}
function c53347303.cfilter(c,ft,tp)
	return c:IsCode(23995346) and (ft>0 or (c:GetSequence()<5 and c:IsControler(tp))) and (c:IsFaceup() or c:IsControler(tp))
end
function c53347303.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	return ft>-1 and Duel.CheckReleaseGroup(tp,c53347303.cfilter,1,nil,ft,tp)
end
function c53347303.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c53347303.cfilter,1,1,nil,Duel.GetLocationCount(tp,LOCATION_MZONE),tp)
	Duel.Release(g,REASON_COST)
end
function c53347303.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,c:GetControler(),LOCATION_GRAVE,0,nil,RACE_DRAGON)*300
end
function c53347303.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local loc,tg=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TARGET_CARDS)
	if not tg or not tg:IsContains(c) then return false end
	return Duel.IsChainDisablable(ev) and loc~=LOCATION_DECK
end
function c53347303.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c53347303.disop(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.NegateEffect(ev)
end
