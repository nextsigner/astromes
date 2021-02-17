import QtQuick 2.7
import QtQuick.Controls 2.0
import unik.UnikQProcess 1.0

ApplicationWindow{
    id: app
    visible: true
    visibility: 'Maximized'
    color: app.c1
    property int fs: width*0.025

    property color c1: 'black'
    property color c2: 'white'
    property color c3: '#ff8833'
    property color c4: '#88ff33'

    property string stringHoraDeInicio: ''
    property int h: 0
    property int m: 0

    property date date1
    property date date2
    property date date3
    property date date4
    property date date5
    property date date6
    property date date7
    property date date8
    property date date9
    property date date10
    property date date11
    property date date12

    property int cNumMes: -1

    property var arrDates: []
    property var arrSignos: ['Aries', 'Tauro', 'Geminis', 'Cancer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var arrSignosRes: ['Ari', 'Tau', 'Gem', 'Can', 'Leo', 'Vir', 'Lib', 'Sco', 'Sag', 'Cap', 'Aqu', 'Pis']
    property var arrMeses: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']

    onStringHoraDeInicioChanged: {
        let m0=stringHoraDeInicio.split(' ')
        let m1=m0[3].split(':')
        let m2=m0[2].split('/')
        let d1=new Date(m2[2], parseInt(m2[1]-1), parseInt(m2[0]), parseInt(m1[0]), parseInt(m1[1]))
        let s='Signo '+app.arrSignos[arrDates.length]+' '+d1.toString()+'\n'
        info.text+=s
        arrDates.push(d1)
        if(arrDates.length===12){
            info.text+='Comenzando creación con ZodiacSever...\n'
            tMkZodiac.start()
        }
    }
    UnikQProcess{
        id: uqp
        onLogDataChanged:{
            //console.log('LogData: '+logData)
            app.stringHoraDeInicio=logData
        }
    }
    Item{
        id: xApp
        anchors.fill: parent
        Row{
            spacing: app.fs
            XSetMes{
                id: setMes
                width: xApp.width*0.5-app.fs
                height: xApp.height
                onSeted:{
                    info.text='Iniciando proceso...\n'
                    info.text='Mes: '+nomMes+' Num: '+numMes+' Año: '+anio+'\n'
                    app.cNumMes=numMes
                    uqp.run('/bin/bash ./search.sh 1 '+numMes+' '+anio)
                }
            }
            Rectangle{
                width: 2
                height: xApp.height
                color: app.c2
            }
            Flickable{
                id: flick
                width: xApp.width*0.5
                height: xApp.height-app.fs
                contentHeight: info.contentHeight
                clip: true
                TextArea{
                    id: info
                    font.pixelSize: 30
                    width: xApp.width*0.5
                    //height: xApp.height-app.fs
                    color: app.c2
                    onTextChanged: flick.contentY=info.contentHeight-xApp.height+app.fs
                }
            }
        }
    }
    Timer{
        id: tMkZodiac
        running: false
        repeat: true
        interval: 8000
        property int v: 0
        onTriggered: {
            if(v<12){
                let d=new Date(Date.now())
                let ms=d.getTime()
                let nom='Mes '+app.arrMeses[app.cNumMes - 1]+' '+app.arrDates[v].getFullYear()+' '+app.arrSignos[v]
                info.text+='Creando pronosticos del mes : '+nom+'\n'

                let cmd2='wine /home/ns/zodiacserver/bin/zodiac_server.exe '+(nom).replace(/ /g, '_')+' '+app.arrDates[v].getFullYear()+' '+parseInt(app.arrDates[v].getMonth()+1)+' '+app.arrDates[v].getDate()+' '+app.arrDates[v].getHours()+' '+app.arrDates[v].getMinutes()+' 0 0.0 0.0 Centro /home/ns/temp-screenshots/'+(nom).replace(/ /g, '_')+'.json '+ms+' 3 "/home/ns/temp-screenshots/cap_'+ms+'.png" 2560x1440 2560x1440'
                unik.run(cmd2)
                v++
            }else{
                setMes.bot.enabled=true
                stop()
            }
        }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Component.onCompleted: {
        //uqp.run('/bin/bash ./search.sh 1 3 2021')
    }
}
