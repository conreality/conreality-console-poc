import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ListView {
  signal selectionChanged(string uuid)

  anchors.fill: parent
  topMargin: 0
  leftMargin: 0
  bottomMargin: 0
  rightMargin: 0
  spacing: 4

  focus: true
  //keyNavigationEnabled: true // https://bugreports.qt.io/browse/QTBUG-57621
  highlightFollowsCurrentItem: true

  model: cameras

  delegate: ItemDelegate {
    width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
    height: frame.implicitHeight + label.implicitHeight + 8*3

    Item {
      anchors.fill: parent

      Image {
        id: frame
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 8
        width: 160
        fillMode: Image.PreserveAspectFit
        source: "image://camera/" + model.uuid
      }

      Label {
        id: label
        anchors.horizontalCenter: frame.horizontalCenter
        anchors.top: frame.bottom
        anchors.topMargin: 8
        anchors.bottomMargin: 8
        text: model.label
      }
    }

    highlighted: ListView.isCurrentItem
    onClicked: {
      ListView.view.currentIndex = index
      ListView.view.forceActiveFocus()
      ListView.view.selectionChanged(model.uuid)
    }
  }

  ScrollIndicator.vertical: ScrollIndicator { }
}
