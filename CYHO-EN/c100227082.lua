--Danger! Bigfoot!
--Scripted by AlphaKretin
function c100227082.intial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100227082,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100227082.spcost)
	e1:SetTarget(c100227082.sptg)
	e1:SetOperation(c100227082.spop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100227082,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,100227082)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c100227082.descon)
	e2:SetTarget(c100227082.destg)
	e2:SetOperation(c100227082.desop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e3)
end
function c100227082.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsPublic() and c:GetFlagEffect(100227082)==0 end
	c:RegisterFlagEffect(100227082,RESET_CHAIN,0,1)
end
function c100227082.spfilter(c,e,tp)
	return c:IsCode(100227082) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100227082.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100227082.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) and Duel.IsPlayerCanDraw(tp) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c100227082.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if #g<1 then return end
	Duel.ShuffleHand(tp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local tc=g:Select(1-tp,1,1,nil)
	Duel.BreakEffect()
	Duel.SendtoGrave(tc,REASON_EFFECT+REASON_DISCARD)
	if not tc:GetFirst():IsCode(100227082) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=Duel.SelectMatchingCard(tp,c100227082.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if #sc>0 and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP) then
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
function c100227082.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetPreviousLocation()==LOCATION_HAND and (r&REASON_DISCARD)~=0
end
function c100227082.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c100227082.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
