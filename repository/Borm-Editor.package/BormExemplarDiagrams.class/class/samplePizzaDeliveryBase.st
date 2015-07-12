samples
samplePizzaDeliveryBase
	<sample>
	^ 'pCustomer(''Customer''){
sInit(''wants pizza'', initial)
aOrder(''ordering pizza via phone'')
sInit -> aOrder
sWait(''waiting'')
aOrder -> sWait
aPay(''accepts pizza and pays'')
sWait -> aPay
sFinal(''purchase complete'', final)
aPay -> sFinal
}
pOperator(''Operator'', System){
aProcess(''processing order'')
sAccepted(''order accepted'')
aProcess -> sAccepted
aDelegate(''passes order'')
sAccepted -> aDelegate
sFinal(''order processed'', final)
aDelegate -> sFinal
}
pKitchen(''Kitchen'', Organization){
aAccept(''accepts order'')
sCook(''cooking pizza'')
aAccept -> sCook
aDeliver(''hands over pizza'')
sCook -> aDeliver
sFinal(''order completed'', final)
aDeliver -> sFinal
}
pDelivery(''Delivery Boy''){
aAccepts(''takes pizza'')
sDrive(''driving to customer'')
aAccepts -> sDrive
aDeliver(''delivers pizza'')
sDrive -> aDeliver
sDriveBack(''driving back'')
aDeliver -> sDriveBack
aPayment(''gives money to cashier'')
sDriveBack -> aPayment
sFinal(''delivery done'')
aPayment -> sFinal
}
pCashier(''Cashier''){
aAccept(''accepts money'')
}
' asBorm: 'Pizza Delivery'