import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: r
    property alias bot: botCrear
    signal seted(string nomMes, int numMes, string anio)
    Column{
        anchors.centerIn: r
        spacing: app.fs
        Text{
            text: '<b>Crear Pronóstico Mensual</b>'
            font.pixelSize: app.fs*2
            color: app.c2
        }
        Item{width: 2; height: app.fs*2}
        Text{
            text: '<b>Seleccionar Mes y Año</b>'
            font.pixelSize: app.fs
            color: app.c2
        }
        Row{
            spacing: app.fs
            Text{
                text: 'Mes'
                font.pixelSize: app.fs
                color: app.c2
            }
            ComboBox{
                id: cbMes
                width: app.fs*12
                font.pixelSize: app.fs
                model: app.arrMeses
            }
        }
        Row{
            spacing: app.fs
            Text{
                text: 'Año'
                font.pixelSize: app.fs
                color: app.c2
            }
            ComboBox{
                id: cbAnio
                width: app.fs*12
                font.pixelSize: app.fs
                Component.onCompleted: {
                    let m=[]
                    for(var i=0;i<30;i++){
                        let a=2020+i
                        m.push(a)
                    }
                    cbAnio.model=m
                }
            }
        }
        Button{
            id: botCrear
            text: 'Crear'
            anchors.right: parent.right
            onClicked: {
                enabled= false
                r.seted(app.arrMeses[cbMes.currentIndex], cbMes.currentIndex+1, cbAnio.currentText)
            }
        }
    }
}
