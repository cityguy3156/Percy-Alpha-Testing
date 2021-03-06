--Promotion
function c511009143.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511009143.cost)
	e1:SetTarget(c511009143.target)
	e1:SetOperation(c511009143.activate)
	c:RegisterEffect(e1)
end
c511009143.listed_names={511002634,511002731,511009178,511009179}
function c511009143.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,Card.IsCode,1,false,nil,nil,511002633) end
	local g=Duel.SelectReleaseGroupCost(tp,Card.IsCode,1,1,false,nil,nil,511002633)
	Duel.Release(g,REASON_COST)
end
function c511009143.filter(c,e,tp)
	return (c:IsCode(511002634) or c:IsCode(511002731) or c:IsCode(511009178) or c:IsCode(511009179)) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511009143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511009143.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511009143.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009143.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		g:GetFirst():CompleteProcedure()
	end
end
