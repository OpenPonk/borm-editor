"
Icons for BORM visualization.

IconFactory new 
    createIconsFromDirectory: '/home/peter/prog/dynacase/git/borm-editor/icons'
    inClass: BormEditorIcons.

BormEditorIcons current initializeIcons
"
Class {
	#name : #OPBormEditorIcons,
	#superclass : #Object,
	#instVars : [
		'icons'
	],
	#classVars : [
		'Current'
	],
	#classInstVars : [
		'current'
	],
	#category : #'OpenPonk-BormEditor-Icons'
}

{ #category : #'instance creation' }
OPBormEditorIcons class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> activity16Icon [
	"Private - Generated method"

	^ icons
		at: #activity16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self activity16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> activity16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/activity16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADMMAorUXQAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAMLSURBVDjLbZJfaNt1FMU/3yS/pbYu/YeMNNHOdEon
Cyg+CGXQChYKggWLRcrA+iKsVAOWWZijFcoGe9DhhE5HHnyxKL70tcG2VluVLZoOalbt1swm
1a5Lmpj8fvn7y+/6MExX3YH7ds7l3HuOEhH+C8uyMAyDZDIpuVwOTdNobGykpaVFOZ1OlFI1
roOHIJfLEQqFZGlpCZ/PRyaTIZfLMTQ0JH6/X9XV1e2TReTAVCoVVldXZWJiQjYTlrz3scj0
1yI7uxkJBAKytbUllmXV+P9zoOu6b3Fxkf7+fl4/U+DarwpsDnTDhdvtJpVK0dbWht1uB8D2
oFhEKBaLt+PxOCf8z7F+y4BqAcw8N34r4/P5SKVSmKZZ0xxYoJRC07SLbrebH3/4jsnTThq0
AkePlHn3lJ1IJIJhGFQqlYf/oFqtEovFJBAIyN5eWs59uCs3b5WkWhUREclkMjI6OirRaFRM
00REUA/GWCwWWVlZkc3NTYqOV3jng20OHz7E8afq2diy6D35KKdeuk65XKavr081NDTsnyAi
ZLPZvVAoxMDAAJc+uwPVArm/da79vEelaHDnD4Oenh7W1tYolUpvHUjBNE3i8XizYRiks3XE
YmlQdo4/7WLuSz+PtzmJx+PMzMzQ0dGBpmlXlVL3HVSrVXZ2dmR2dpbh4WEuf/o7mHkwC9xc
T/Lqm79wL1VmamqK7e1turq6qK+v30/BMAyWl5fxer3cTR7h8vQNNFXi/NljPOmxEQ7f5eTL
y5w9d4lMJkMikdhPwrIsNjY2ZHx8XP78S5fHvEHhkSsS/HxdFhYWRNeL8tob3wtNX8nzL87L
7r20jI2N1Rpp+7e+Ho+HRCJLiwvG3n6GZ0/oBINBJiffJ/jJCxx7wsFRj4Ni6RBNTU01Bw6l
FK2trel8Pt+89O0XXP9pBF3PcuHCeUZGRkgkElyZ/oho+AyRSJjg1Yt4PB6am5t7lVL3e2Ca
JslkUqLRKHNzc9hsNgYHB+ns7MQwDObn5wmHw3i9Xrq7u2lvb+91uVzf2O12/gGZc7kbIRNE
GwAAAABJRU5ErkJggg=='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> communication16Icon [
	"Private - Generated method"

	^ icons
		at: #communication16Icon
		ifAbsentPut: [ Form
				fromBinaryStream:
					self communication16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> communication16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/communication16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADQr6MH38QAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAFxSURBVDjLpc8hiypRGIDhb4cRR2wGp4iCI9hsYjXs
L/AHGBzLYDdZZbAJKohpgmkNRqPBKRNNGvQXCCIiioi+N1zuueuuN9zZAx+ccJ73nPMGSJg1
n8/ZbDYigCyXS0qlEvF4HMuy6PV6APJ17ve7TCYTUqkUIkIQBMh2uyWZTGKaJvV6nXw+j2EY
+L6vIpfLRYbDIblcDhFBRMhmswAirVaLWCzGarUCkOPxKMVikU6nw36/f2+325imqeCfmc1m
vwPlcpl0Ov3yyYvFAtu20XX9CRcKBXVeqtUqiUSC8/msYKPRYDQaqUOO4zwFxuPx38B0OsUw
DGzbZrfbffT7faLRKM1mE0Bc10VEcBwHXdfJZDLcbjd1mQBSqVSIRCJomoamaViWxfV6Vdh1
XQCp1Wp0u92n76rNer1mMBgQBAGPx+MbBsT3fU6nk7wMfJ5X+F/zI/wt8L/4KRAGq0BYDIh4
nhcaAyKHwwHP80JhQH4B0XFwur8ipyMAAAAASUVORK5CYII='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> constraint16Icon [
	"Private - Generated method"

	^ icons
		at: #constraint16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self constraint16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> constraint16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/constraint16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADMhR1WIKAAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAE1SURBVDjLpVMxq4JgFD3fQ9HNta2tqUWem5OLtNVW
kzWKOAo69ivSv+DUD2gxaGh40NjUJjoIgk2CyH3De0plg9KFC/ceznfu5TtcRkT4JLi+xPv9
DtM0Kc/zFttsNmC73Y6Konj7yPM81tRRFJGmaXBdFwBwOp3AcRzYYrGgNE07067XK4ioI9Bg
2+2WoigCt9/v2evkhtwnvvBhPAnEcUyvrpRliSzLfnoJXC4XyLJMQRAAACzLoslkQnVdf/cS
mM1mLEkShGEIAPB9H9PpFKPRiPUS4Hkeq9XqibBer4d9omEYbS1JEubzORskoCgKG4/HAIDl
cglRFIfbqOt6Z5tBt+A4Dg6HA1RV7ax/Pp/p3/I/gIje5vF4pMf+druRJEkEoE3btokNOeeq
qlDXddsLgoBfctCfQrEb8q0AAAAASUVORK5CYII='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> dataFlow16Icon [
	"Private - Generated method"

	^ icons
		at: #dataFlow16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self dataFlow16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> dataFlow16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/dataFlow16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADM5VDkQfgAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAJKSURBVDjLpZK/SxthHIeft7nGwF0Og2CojVSLOISk
ihAEIZtCcLEodtWlHfw/FBzEoUvbtVUk4ipKLcagoJMZY8K5HDEiJpcYItHL3dtB/FGqpeAH
vsvLy/O8fN+PkFLynCj/c+mhREqJbdtIKVEU5WmA67o0m01qtdqnRqPxtVqt4vF4KJfLXFxc
4DgO4XD4b4CUkkajgWEYslAokMvlqFQq+P1+WltbCQaDhEJv0DQ/qdSvxwHZbFZmMhnC4Qhj
Yx+p1XyUy1CtQqUCzSb09OTxer33ANu2sW0bIQRXV1d0dLwmn4+xsgI+H7S03EwgAENDFktL
q0xMTKC4rkupVEqenJxMZrNZAoEAp6en7OzsMDfXz/l5O8fHN1aARMJhefkLo6OjdHd3C3F2
dpbc3Nyc9Pv9RCJxSqUCppmjt/c93797cBxwXbi+hulp2N//TCwWIxqNClVVERsbG7Jer5NK
jbO9De3t0N8PuRxMTcHgYJFk8hWhENj2D1RVZWRkRGiaBsCLfD6Pro+ztgb1OhSLkMnA4qLF
0dEs8/OzDA9DMJhGURTi8fiqqqr3RRJC4PXa1OsvcRxwHNA0ODzcIhqNEolEODj4hqIoJBIJ
2traPggh7r9td3dXrq9vyZkZKTVNyq4uKff2HLmwsCBN05TVahXDMKRlWW9vG/hwRLFYlOl0
mmazSWfnOy4vCxiGwcDAAH19fcLn893J/jDfnrmuS6VSGTZN86dlWei6jq7rBIPBu0X9K+L2
Ka7r3jXR4/E8ansS8Jz8BhxTJrrtOHjNAAAAAElFTkSuQmCC'
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> dataFlowLeftIcon [
	"Private - Generated method"

	^ icons
		at: #dataFlowLeftIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self dataFlowLeftIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> dataFlowLeftIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/shapes/dataFlowLeft.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAACMAAAALCAYAAAD1JjQCAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQECDouojK3wwAAAoRJREFUOMu9VE9LYnEU
Pb/0Kb6KhBCiv6hhGEF9gJIWQxjtxIFC2kTfYdpEFG3erg/QB5CghBa1kHAjFKi9ROnFq0jI
Xuqjoj9kmzizmphIJ93MhbO793DvufceQRLfxZ+carWK6+trXl5eor+/HyMjIwJNxNPTEzRN
o2makCQJfX19GBgYELIsQwgBayMk5XKZmUwGuVwOqqrCMAysrq420weOjo64u7uLVCqFYrEI
u90On8+HQCDAmZkZuN1uAZI1YZrm1v7+PhVF4fz8PIeHh+lwOCjLMkOhEOvV1UIymWQ4HGZb
WxsBfEAIQZfLxbW1NZqmufVJmdvbW+bzeWiahtPTU6iqiouLCzw8PHysqqenBxMTE02pEo1G
kUgk8PLy8mX9pmlie3sbg4ODP8X9/f2P8/Pz+NnZGVRVRSqVQj6fx+PjY03izs5OBINB+P1+
WK1W/OvmSOLt7Q3RaBS6rtfNkyQJCwsLgKZpXF5eZnd39ycJ/zfm5uZodblcytTU1K+uri4c
Hx/j5OQEuq7j+fm55hROpxOTk5PweDywWCzffmG1WsXe3h6urq7q5lksFrS2tuLToRUKBcZi
Ma6vrzMSiXB0dJROp5NCiI8Jent7ubGxwff394YPeHFx8QvP3/D7/dzc3KxPUKlU0rFYjCsr
KwyFQvR6vZQkibIsc3Z2tqlvisfjnJ6eps1m+9JIR0cHl5aWaBgGxXemRxLFYpGHh4fIZrPI
5XK4u7uDoigYHx9v2PQODg64s7ODdDoNwzBgt9vh9XoRCAQQDocxNDQkRKMOTBKvr68oFArU
dR0ejwdjY2NNOfDNzQ01TUOpVILNZoPb7YbP5xPt7e1oaWnBb847+Kj1GEhBAAAAAElFTkSu
QmCC'
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> dataFlowRightIcon [
	"Private - Generated method"

	^ icons
		at: #dataFlowRightIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self dataFlowRightIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> dataFlowRightIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/shapes/dataFlowRight.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAACMAAAALCAYAAAD1JjQCAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQECDof8+y3+QAAApBJREFUOMu9VDFLcgEU
PbcUemYJyQN7WhbRo1e+ns80lMbHtzg0SJANQZtLf6GlJZwibG5saI/CScSgwQ8aggdSVgYO
SZEIgZneb0q+QD91+S6c7d7DuedyDzEzmBkfHx94enri5+dnNBoNiKIIRVFofHwcg9Tt7S2X
SiXMzc1hamqKBEEAABBRz1kLADw+PvL5+Tmy2SwKhQLq9To8Hg9CoRCvr68jHA5Tv2JeXl5w
cHAASZKg6zqrqoqVlRW4XK7eHJVK5Wx/f59FUWQiYgBt2O123tjY4Fwux98O9oNYLMY2m40F
QeDFxUXe3t7mZDLJFxcXXKlUzrrN4fT0lDVN+yHibzidTt7d3R1IzOHhIbvd7jYHEfHExASv
rq5yIpHgo6MjTqfTXC6Xf/BSIpHgk5MTNBqNru7Jsox4PI6RkZF/3p6I8PX1BdM0cXl5idfX
1459DocDPp8PoVAIuq5jYWEB8/Pzv7C1tdXVlf8BSZJ4b2+PTdNky+joKIaHh9FsNrtuPDs7
i2g0CkEQen5Fs9lEsVhEJpPB+/t7x56xsTHIsgy/349AIIDl5WWIopi0hMNhXF1dwTTNjrY7
HA4YhoHj4+O+PqrVaiGVSnE+n2+L+ebxer3w+XxQFAVLS0vQdR1er7fNa4lGo7i7u0O5XEa1
Wv1BbLVaEYlEsLm52XfODA0N4fr6Gm9vb7BarZienoamaVBVFX6/H2tra79FUQx2zJnJyUna
2dlhu92ObDaL+/t71Ot1SJKEYDCIWCwGwzD6zplcLselUgmGYUBVVWiahkgkAo/HQ71OTMyM
VquFWq2GQqHADw8P+Pz8hMvlgqIocLvdNEgC39zccLFYhCzLmJmZIZvNBiLqK4H/AGLEf54Z
60XqAAAAAElFTkSuQmCC'
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> entity16Icon [
	"Private - Generated method"

	^ icons
		at: #entity16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self entity16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> entity16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/entity16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4AcdDjUsULRhLwAAAddJREFUOMulk0FrE0EU
x/8BYUjcQywWA1URTx6CVz1F9CRioeClXQh7E+lNQSFQes1X8OZN+iH6HRQ2l1LamLhsKpmm
TQeyO5uZ+XuYJCLWCHbgwTAz7/fm/d97JZK4yro233Q6HbbbbWitlzoIIdBqtVCv10sAAJKI
45hRFFFKSaUULy4Ux2PF83PFszPF0cjb6alimko2mxHjOCZJDwjDkFJKkqQx5GRCjseklOTg
hEwSstcju13y+Jj8nkiGYUiSPgWtNYQQsBbQGhgMJHr9BGYKGAs4C9yq3UMQVEEHVCpikepC
AxIoCm97e5+xu/sWKyurmGu8s/MRjScbIAHnLhGRBKZToJgC1gK12m3s7/dQTP25NUCee+e/
AoyZPbbAaDTE9vYGHAE64P2HT6hUbvwbYGYAIcp49Pi518EBjgJ57u/sUoDxEcrlAOvrb6C1
F7YogGwGcPYSAODJ8wjDYYqtrQeg8/AXL9+h0XgNa5ak4Jx3fvb0Fe7eeQg9q4ougGr1PrT2
Gv0BEMLXlQxAAjdX13A9WEOW+W/nGRZ7rYFJ5vvmt1ZuNiMmieTJD8U0VUwSxX5fsftN8ehI
8fBQ8eBA8ctXyc3NX61cmk/j/w5T6arj/BO7031tDWM5IAAAAABJRU5ErkJggg=='
]

{ #category : #'gt-inspector' }
OPBormEditorIcons >> gtInspectorIconsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Icons';
		display: [ 
			self iconSelectors asSortedCollection 
				collect: [ :each | each -> (self perform: each) ] ];
		icon: [ :each | each value ];
		format: [ :each | each key ]
]

{ #category : #initialization }
OPBormEditorIcons >> iconSelectors [

	^ self class selectors select: [ :each | 
		  (each asString asLowercase endsWith: 'icon') or: [ 
			  each asString asLowercase endsWith: 'logo' ] ]
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> initialIcon [
	"Private - Generated method"

	^ icons
		at: #initialIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self initialIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> initialIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/initial.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGAR4Pumu1PwAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAK8SURBVDjLpdI9SBthGAfw/zWX5C76vndnxBiNVqxg
Y4hGjB+pS0sRlFPq1KXtZim0aJcMHYrYxIq14Cxdi3XoasgiBT8ydiwuUUSQ1g9scn7gYO7p
IDm1WuvHHx54h4cff14elBYX08fRUdrZ2QER3XhwLxgkvyRRmarSyPAwGYZxMzCRSFCYc1r2
+eiZplGZqtL7ePzaMEzTRGtdHSU9HqKqKlr2+eipppFXUa4Fg4gwPT1NTZwTVVVZs3QSjsUo
m83CNM3LgaZpoi0QsFr+DT+5Amw9EokENSnKGfAUrKpUyjkNx2KUyWTOhQUiAnAER4JBGtra
Qqcs419ZOjzE4O4uvpkm+qNRvBoYEDjnEAQBAHArvygIAgbHxvD24AAX5Y4oYlJVscA5foyP
425lJY3E45TJZKpPNcy3vF1SQkmnEwG7HZfJwsEBOjc2UFJRgUQyedwQAFKpFBUToe4S2K9c
Di+3t9GztQW3xwNveTkmJiYgnlwaikYxaLNB+A8Uy2Yxtb8Pl6bB4/XC6XTCZrMBwDE4Pz9P
2+k0HjF2LrSey+GdYWBqb8+CJEkCYwwNDQ3o6elBY2Pjb+sPH7a2Uv/KCnpdrgshVlQESZKg
KApCoRC6u7sRCoW+c87DDofjqOHc3Bz9Xlo61W49l0PMMPAl36i0FLIsQ1EUhMNh6LqOYDD4
lXP+2G63W2cjEBEeNDfT69VV9LpcZyBWVARZlqGqKlpaWqDrOgKBwAfG2JuTUD7i7OwsZZeX
ESkowIBh4LNhnGqkaRra2tqg6zr8fv8LxtgnURTPQNY9329qouziIn7abHCpKhwFBZAkCW63
G5FIBLquo7a2tqOwsHDmIsgCi1WVnvf1YWVtDel0GoqioL29Hbquo6ampoMxNiOKIi4bYXNz
k1KpFCYnJ1FfX4+uri5UV1dfGcrnD/XhNjfKnXGJAAAAAElFTkSuQmCC'
]

{ #category : #initialization }
OPBormEditorIcons >> initialize [
	super initialize.
	self initializeIcons
]

{ #category : #initialization }
OPBormEditorIcons >> initializeIcons [
	icons := LRUCache new 
		maximumWeight: 64;
		factory: [ :key | self perform: key ];
		yourself
]

{ #category : #'gt-inspector' }
OPBormEditorIcons >> inspectionIcons [

	<inspectorPresentationOrder: 40 title: 'Icons'>
	| selectorsByForms |
	selectorsByForms := (self iconSelectors collect: [ :each | 
		                     ([ self perform: each ]
			                      on: Deprecation
			                      do: #resume) -> each ]) asDictionary.
	^ SpTablePresenter new
		  items:
			  (selectorsByForms keys sortedAs: [ :each | 
					   selectorsByForms at: each ]);
		  addColumn: (SpImageTableColumn new
				   title: 'Icon';
				   evaluated: [ :each | 
					   [ 
					   each scaledToSize:
							   (50 min: each width) @ (16 min: each height) ]
						   on: Deprecation
						   do: #resume ];
				   width: 50;
				   yourself);
		  addColumn: (SpStringTableColumn new
				   title: 'Name';
				   evaluated: [ :each | selectorsByForms at: each ];
				   yourself);
		  yourself
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> oRModel16Icon [
	"Private - Generated method"

	^ icons
		at: #oRModel16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self oRModel16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> oRModel16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/diagram16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGARcHZXKGRAAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAKISURBVDjLjZFPSBRxHMU/v5lx2l1t180t/xK1SEKF
WAeRIA9FZocI6xBE5yzNLiKsdRPzpAQdCqNTdOiQ5CU9FKhoIGnqhppireyC6/pvdUR3Z9cZ
p4ssLGvQ9/h9733f432FYRi0tHyxPB4HYAFgGPs0Nl6sz83NeSNJEv8aIQRKPB7H7XbQ2Fid
AjRNx+f73F1S4urOylKwrHShJAlqa09TXl4slGQyiWmaaQSXy0Zn551/Oq+s7NDTM4jX60J5
+XLcCgR2ef16lP8dXTfw+9epqvpjKbEYtLXVHUo0TQNZVg7F+vpczM5Oo+zt7RONHu7U3t5A
ZeVVamruEgr9YG6uN4XNzITItsdQLAs2NtKF/f1vmZ4ewTQNOjoaWFoKUlbWjc8XSHGe+rKZ
G7OjCCEyEkxMjFBRcYPNzTALC34CgVeoqk5zc/7Blwwuntzl+Fk3iqrKGQkSCXA4ytjYiNHU
NIRhXKa1NZjCR0ZgZzKLubCE4nKphMM6NpvtoLgk66s/+eV/RZ47n3n/CwpPRTILilkk4jJK
cbGdgYFd3G4bppkkGrrN+JtJXDmTAEz9lvk4Y2Xo3/cfofb+Q5SiIjurqztYVh6ry48pPvad
Z+/yU8TNmM65Qo07dddQbSexLIPl5VEM/RKV1ddRPB4HmqYhy6DaZd5+WEtzan5UwL3zGl8n
nmBzXmFs7BaatoLbPYEsyyiFhUdFJPLNikbDFBSEMqIasQTbKxJL4SnMSARVvYAkBfB6K9ja
2kJxOrPp7a0gGAwyNLSX2dWOwfPBM9TeXEOIdQB6epJ0dT2gtLRUCNM00XWdRCLB8PAna3Fx
IO3A/Ow2eSfKEUKkdk6nk/r6emG32/kLTPUPZfrsIJ8AAAAASUVORK5CYII='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> organizationIcon [
	"Private - Generated method"

	^ icons
		at: #organizationIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self organizationIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> organizationIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/organization.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGAR0UGyMvEAAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAARJSURBVEjHnZZdbNNVFMB/9/a7XdutKx9CkEyJkOCA
OGVjKKLGLIREVGAMFAeECJH4qJsxMb5o4A0THwAfiCZKIuEBYnxAQjRzlCEsmy5sjI8BI+y7
XVfW7v/R//WBrrTrIA335X6c///87rnn3HOuOHfXYramlMqOhRA8bbMXKLYsHkyMfzyZiB81
dA0At7cEl9tzyDSNJgCvzy9cHm9RYJFrgVKKiejo5Ymev6tqqypxuVwA9N+7z+X/eqh6cSkI
wZXr91m0cm0sWBYOCSmLB5imwc2OiNqzoZrOa4LuWyYg2fi6izkhyUhMAQK7GOfHU78zv/I1
wvMWiCdB5IyDx5hK4na7OXMuwe6mIXZ/MUrXdZPuW2mqtz+g5sMkQ+NBPtm5hXhPKwP9fSpt
msUBpLTh8odIpVLMDQmwTLAMzpxPsqZhlL5+jVt3DWp3pmjttLPvowacw1e509ulDF3LC4xZ
AUJKvIEyBgYHmROSYBlgmRw+HiU+oWeBsXGDuv0pjp+22Pb+Oyx2xLnR2aa0VLIAInMdPJmI
Pzd0swuXy8XccltWYbZXj8aGbrLnqxRffp/m7TfWs6YiSO8/f6rkg4k8iFRKYaXTxMdGojfa
/ri57a1XKC+fz7Gfh/IUzgbBMvn2hykamk2WL1/Fu69W0hs5q+JjI1ErnUYphTjbZxAdGVQD
nX/RuGUjZtrLpl1dRNonQTpA2kFkepnTz1hbs8rJ6cMO7GKc4yd/Y+Gq9YTmzBcyNjasYt2t
HGisZ3DYRnXdBSKXRvN3XoQlkQ6d6p0Gg7FSPt21jVh3K7GxYSWHrrWzd8dmWiJRauvO03c7
DmqGsiIhff06tY06LR129u7YzNC1duxCCCzL4s1184j1bco6Z/9nXRz96X5hzFmFcbhvq5cj
XwfylnXdQgiB/ZllL588cuL01rDPiVIWUllsr98MVjpjCXx+4FkqFnsfahOSX87Eabms5VzQ
NAAnfj2FJSRCSEYndRauWHfSHigrr3eurkPXpg7qU6mmO52tj36yDJDw3oYwVSu8JBIJQqEQ
HVeTtFyaLADciWksXrkWp9tzqMLlbnZ7vEghJR5fCcFQuDkQCgun2zOdVjNnawCKSNslvvnu
6CNZ7vlnAE63h0AoLIKhcLPHV4KQsjBd5+3KMrM5ymaz4fMHH86tjGzaJxlAUfUgH2BMTx4v
k4BlPSUg42SUerx1ADzBgty8kZeopn0gcy2YrmBWjnWZb3N05OrJs8Bms+Hw+tE0jcYPXqBm
9TwQkucrSmjvSOHw+jEMg8b6BdRUlWbDdukSL5qm4fD6sdls+RXt7G0zjz4+NqxSNy5SW7UC
h8MBwOhYlIs99wgsWoYY6KLmpUqcTmfOpdK5cOVfPEtqKC2fK3JrdR5gZtE3dT1T9H2UBMuE
w+liMhE/mEzEm4yMTAiB3enE5w/uKwmUHptZPgsAxTxbZqtcj3th/A9/UGDY/JrFzAAAAABJ
RU5ErkJggg=='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> participant16Icon [
	"Private - Generated method"

	^ icons
		at: #participant16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self participant16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> participant16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/participant16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADUDxG9uSgAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAALpSURBVDjLfZPBT5t1GMc/v9/79i3wtlKKeyGw4Nqp
gLCsh6WJg8OQzJidiN6M4QSJXt3BxGR/ggezA15NCHrwJHrAg15mNFu1s4NaWIA1JStaoVLe
tnv7vu/v56Ehm8bse3uefPPk+STfr9Bac6Zyuazz+TymaQKQzWbrjuMkeY7ks0Mul6NwcI1o
8jqH3pv89qA8UCwW9fMOmP9d/HjvhM++aFCt9/Da+BS3b1Y5vnNHz87Oimd9WmuEEE8/2Nra
0v0DYxwcnFKtnkLQpLjt8u6tIVw1yfr6uvZ9n06ng+u65PN57XkeQmvN5uam/utI8sHHhzws
gzZslGFjRi1My2J8pMiHixH6+1o4joPjOEgpqdVqXQTXdTn46VM+uhGyVTol0DblnlssXPud
sfP97Lfi1I0YX+cK5AOT21fbTFy8QLPZxFRK8bjwFcGjLwGYsrtIqfMOvnyDb9UETRPuPzpk
13NotdvE7EHCMCQMQ6Tv+zR+/YTMlUtkrlwGIDP+MpmBPYTQ/Ol6bNdcTtodlFIAxGwbpRRB
EHQRMpOvkJl6FXojZCbScORyv7SNMSgo7D3GDRStVouO3wEgHrPxvSdIKTGFEDx5cQaOqxAx
wAvAD9lWF4nZfexX/wAhUGHIWSBeiMeotVsYhoEppaTSM0zv35tcdsagByrWCIfXf8G4u8d3
72QZHR3t8kqJZVkEQYBSCsuyMJbfX9afJ5ZxJ32KnsfQ99PsLlzgQeQb7oY73Bh6j0qlwurq
KslkklKpxMrKCvV6nbm5Ocy1h2vsxZooFOZAg5GTBsdrvRy95VN1dpFSkk6nWVpaAqDRaJBK
pVhcXCSRSAhzZnCGnIrghWAKg1K2TvpejZSdQFQdwt6QjY0N2u02juMwPT3N/Py8iMfj3Th3
Oh2Wfnhbi5d+5lLcps808DXs75zjqr7JwusLQgjBWWsNw0DKpx0UWmt836fZbFLYKWjbshk+
N0wymRTRaPRf5v/TPx/rS42dMRyqAAAAAElFTkSuQmCC'
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> personIcon [
	"Private - Generated method"

	^ icons
		at: #personIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self personIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> personIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/person.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGARwuxDTH4wAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAAT7SURBVEjHjZVbbB3VFYa/vWf2zDlzfC72ceLYFSY3
cVWbQKCoTRWgpSoIIQGRKgEPvNGXJsojon0JalQQVH3hCcELQhUUVUKQKA4EURWiVkAQlzRq
TAnkQuyAHdtzbnP2zOzFw7Ed2zGBJS3t0Wjv9a/9r3+trd46I6w0EUFcTma7dCY/lc7xl3B5
hkhvrz/yc8LRWzFh8XdhVHrW8wOU1qxm6vBpd8nPLLW0PhuT+Mg++Pr9VQ9K0I/btpfy1XdT
HlirTFhcFcRfLfPm+EFpvHoflzNlZ/D+vZspaujrdkh5YEh5JkAptWyfXsENaTfh+4IvNfv/
V4mnJslsgrhL2VhxJyF+Z6/80ODrh4e5JnyP5oWv6babIuK+myIRweU56TfHAVi3bg3bb7+F
8mCN1nTCO2+/y+TE5OLBHdu2sLG/zkenzzA+/jzd0T8TVQfQnr+MpktqkJ06yPCaOnf+cjtE
AYhQ6o+4c+evwWXQttCxi+vWG2/gn4diOs2YSpbimxCWAFxSdgWsqw9AnkOag81AUsiz3nea
Q+Ygd+AAAckSMpvgsuyRy6pIKYXZsouR0S96wZQC52BBfll+ESTNAWG61UZUgNIeKHXy8kVW
CmX6OHduApSBJO3RseBJ2vNu2rtBFHHm/Hls37UEhQjPN4e/U6ZKKZTWlH665+iHJ6ahPnSR
67aFdre3Jul89sCatfzn6Ofk/T/GD8JVG00v51/hB4Wb/Jv+wNj+/fCjUfDC+RssybxYhI2b
GTv0Bu3fDPFF9D/y1C4bJ6sCiAgijtc2vUDz3pCxg2NMOgfrN8JAvecbNzOJ5uCBA5y9S+jb
3qXyqxf5YHaM1syUpDaBJSCLs0hEcFnKXycelh3rjzASFchFcIcvEJ4zlM4liAjRsQaDjQI3
v9Hk6bn1OAGHsH/c56Hp5xjedD1Rta4W+sFfOiZst8N/5RXuNlcwl6Y4EfIdfTgRfhv9gyvN
z+g8sQ+/WgWgkaY4wImwZjDm8Nm/ce+FPYRRGc/zV1IkvDj3JxnyNUenZ4mtZc5a4jQlTlOe
nd1JJl1wOd2kDcBsmjJrLbPWUtGa98pv05r5Bpu0P3DzY0Mv0uMceZZS8hRfNjuMxy3iNGVu
HmgutTx+/hfkgP3jYxx4fSdz1tLKMnKnqRjD2eqXdJoxWTfZJs4hIvi9wgriHOIcHgqlFJPt
LrHNKBmNp0AQZjjB32eOcd/ICI13xwi2FunzA4zSGN3Tf2YT8ixlIa5e2mQoRSwQeR59xif0
PDQenvIp6pCaXyT0DM2pKW5/psu6QkQtCKgFhmpgepR4PkrrRbnqxSZTivtLuzhlc6qBoX/h
oDFUTC9A1QR89UCZs9sUiVFUjaFqfKrG8K+ZBnecvIeo0o8Ji2itl6tIKU01GlI/iXdK7MbY
EPoYreddYbTGVwrvSs37Lw8zdNRSDQy+VnwUt/jkRI3fuwcpDw5jCpFSSq9QkVKYsMDu+jOv
1Cd2sX86ppELNdPLvGYMNRPQHxpqpYD8tgqHpmZ5+vOv+PjIVvY0/8LQhmup1IeeDArFxZGt
3jyVL3sy8zyj05i9MDc10f9y8hSxnGZgw3G0Uniql8j5Y1fh2yqjdjNbuZXK4DDlgbWUavVN
QbF0UnsX22s5wBKQrJuQtBuSNGOSVkyadHAux/N8/CDEDwqYsIApFAmLfU+aYvSo7we9ibxk
on4LMDxxUbrMRGEAAAAASUVORK5CYII='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> settingsIcon [
	"Private - Generated method"

	^ icons
		at: #settingsIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self settingsIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> settingsIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/settings.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAN1wAADdcBQiibeAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AAEdSURBVEiJ1ZYxbgJBDEWfUYQo6KgokSjpKSK6HCASNTkBHQXnoCVVDpAiDRVtKq4QQYO4
AxLRpMCgwbuzsaLMSlhysd7v/9f2jjUSQiCnNbKyewVEZCoiwfj03wSAR2fszwJ9Z6xoIYSr
AwJ8ACvgGegAC+AEBOMnfddR7Epz5YbTCEwMyXcJsXWLmZQKAG3g4CD8zQ9A+8Ibz2AGdCu6
uQNe1XcVuK5ynS2qYAwcE1/1BrQibEtjZdgjME7NYAjsTcI2JjciW4PdA8PkkDVxbpKWFhNh
lwY7t5jsq6K+FpFpyA9RMQOgmSj0BRiJyFqfn4BeAttUrvebFpHpoNW3KmpZdhX/+6ZEYOPJ
9Z6DL2esYF6BT2esYHL3t4of1ezMdo7TPcYAAAAASUVORK5CYII='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> state16Icon [
	"Private - Generated method"

	^ icons
		at: #state16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self state16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> state16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/state16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADIy2vD4twAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAALPSURBVDjLZZPPa1xVFMc/9753f7z30plOnzQKCeh0
FoGMqAu1EKOiQSm40I127dJFt/Z/0E03deWqUJRC1ZWrlmqhWqk1tigVnUqijQaczjCTzMx7
c9+9LiaJVQ+c3Tmf7/dw+IoQAg9WCIEQAmVZMh6P17z3a8aY09ZaoigCQAhxMC/2ASEEnHMU
RUG32w1nP7vG+r2K1tHAvCx4/eVnqNfrZFl2IU3TN40xSCkR+0u9Xj98+c0696YZO8eepph6
itIzmXp6I8fvfQe3LrN0pGC5FjixtsL8/Pwx0ev1mu99eLnz7qk3+HMc2HGBQQnDqWdQBoaF
ZzipGEwq/hhW9EaO/i9b/HzjV8690yDu9/udCzcV509+yspyTuvRBm+/tczmSFB4QRHgcCSR
gx3uXrnNxXM3oH4IDiVsbY2Jq6pCpxYZOa7dGXDlu/t8cP4OT7YOs/LEUfrDIV9d+omvr29C
aqGWgdWgFc45YgBbs5STCqlmLaKS9c6A67f+QmzepT8oINGQGjAKdIydMwhRzgBmLkUqR6kq
ECUESLUkeyihsxEgkmA0KAVKYVKDzQxCTPcAtQQ5diAKIiCvxchphawqfAB0fKAcJwqdGZTV
AHuAzACC4D21OYV0DukqpKuohACtQMWgFSa1mFRjjPoHoBJN8IFMSzI80kVIVxFVFV7KmbpS
SKPQqUYlGqVioigi1lqjEkXwnoeNQkwdchohqz1AvGffzG7XqcbomEcGX9BoHCfO81ycfuyH
cObjq7jFx8kXlg7sS++RVs/sqxgfxyyMr3KiZXnpxRdot9vfxtZa2u22eH9xMWxvb3Px80/Y
nigWnnqNyFcIM/v5UnKTk88eYXX1FVqtFnmeiyRJ/h+m3d3dZrfb7WxsbPDRpdv8+P1vvHq8
wfOrz9FsNsnzXFhrkVL+O43/jXNRFAyHw/uj0ahhraVer4v9BD5YfwPbkTqZVMc9VQAAAABJ
RU5ErkJggg=='
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> systemIcon [
	"Private - Generated method"

	^ icons
		at: #systemIcon
		ifAbsentPut: [ Form
				fromBinaryStream: self systemIconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> systemIconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/system.png"
	^ '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'
]

{ #category : #'accessing - icons' }
OPBormEditorIcons >> transition16Icon [
	"Private - Generated method"

	^ icons
		at: #transition16Icon
		ifAbsentPut: [ Form
				fromBinaryStream: self transition16IconContents base64Decoded asByteArray readStream ]
]

{ #category : #'private - contents' }
OPBormEditorIcons >> transition16IconContents [
	"Private - Method generated with the content of the file File @ /home/peter/prog/dynacase/git/borm-editor/icons/16/transition16.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA
CXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQGADQWsKm74AAAABl0RVh0Q29tbWVudABD
cmVhdGVkIHdpdGggR0lNUFeBDhcAAADQSURBVDjLpc89aoVAFIbhLzB7sBGEi7WryEq0moXI
tJaWFnYuwNJCG/fgGsRCsBB5U3mJ5OdOzMDpzvNy5g3Qndd1HdM0SYD3HMehpmkIwxBJjOPo
B7dtU1mWxHGMJCTxeDwAfr9gnuf3PM8JguAJz2nb9nWg73uyLMMYc8FJknDueH3BWnsJ1HXt
H3DOIQlrLcYYoihi33d5BU7snANQmqYURcHnHW8MaBgG1nXVy8B3+Kf5F/4S+Cu+BO7gZ+Au
BqSqqm5jQFqWhaqqbmFAH8KYk3fcvoBLAAAAAElFTkSuQmCC'
]
