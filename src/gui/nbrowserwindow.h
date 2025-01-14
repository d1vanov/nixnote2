/*********************************************************************************
NixNote - An open-source client for the Evernote service.
Copyright (C) 2013 Randy Baumgarte

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
***********************************************************************************/


#ifndef NBROWSERWINDOW_H
#define NBROWSERWINDOW_H

#include <QWidget>
#include <QLineEdit>
#include <QGridLayout>
#include <QLabel>
#include <QPushButton>
#include <QMenu>
#include <QAction>
#include <QWidgetAction>
#include <QPushButton>
#include <QComboBox>
#include <QHBoxLayout>
#include <QToolBar>
#include <QTextEdit>
#include <QTimer>
#include <QPrinter>
#include <QThread>

#include "src/gui/nwebview.h"

#include "src/qevercloud/QEverCloud/headers/QEverCloud.h"
#include "src/gui/browserWidgets/ntitleeditor.h"
#include "src/gui/browserWidgets/notebookmenubutton.h"
#include "src/gui/plugins/pluginfactory.h"
#include "src/gui/browserWidgets/expandbutton.h"
#include "src/gui/browserWidgets/urleditor.h"
#include "src/gui/browserWidgets/tageditor.h"
#include "src/gui/browserWidgets/authoreditor.h"
#include "src/gui/browserWidgets/locationeditor.h"
#include "src/gui/browserWidgets/dateeditor.h"
#include "src/gui/browserWidgets/colormenu.h"
#include "src/gui/browserWidgets/editorbuttonbar.h"
#include "src/gui/nwebview.h"
#include "src/xml/xmlhighlighter.h"
#include "src/gui/browserWidgets/editorbuttonbar.h"
#include "src/gui/browserWidgets/reminderbutton.h"
#include "src/html/thumbnailer.h"
#include "src/email/mimemessage.h"
#include "src/hunspell/spellchecker.h"
#include "src/gui/findreplace.h"
#include "src/threads/browserrunner.h"
#include "src/html/enmlformatter.h"

class ToolbarWidgetAction;

using namespace qevercloud;

class NWebView;
class NBrowserWindow;
class NMainMenuBar;
class EditorButtonBar;

class NBrowserWindow : public QWidget
{
    Q_OBJECT
private:
    QThread *browserThread;
    BrowserRunner *browserRunner;
    void setupToolBar();
    QTimer *sourceEditorTimer;
    bool insertHyperlink;
    QString currentHyperlink;
    bool insideList;
    bool insideTable;
    bool insideEncryption;
    bool insidePre;
    bool forceTextPaste;
    void editLatex(QString incomingLid);
    QString selectedFileName;
    qint32 selectedFileLid;
    void rotateImage(qreal degrees);
    void updateImageHash(QByteArray newhash);
    void insertImage(const QMimeData *mime);
    qint32 createResource(Resource &r, int sequence, QByteArray data, QString mime, bool attachment, QString filename);
    PluginFactory *factory;
    Thumbnailer *hammer;
    QTimer focusTimer;
    QTimer saveTimer;
    QString attachFilePath;  // Save path of last selected attachment.

    // object of interface
    SpellChecker *spellChecker;

    void createSpellChecker();
    bool initializeSpellCheckerWithLocale(QString local);
    QString initializeSpellCheckerInitial();
    QString getSpellCheckerLocaleFromSettings();
    void saveSpellCheckerLocaleToSettings(QString locale);
    void spellCheckAddWordToUserDictionary(QString currentWord);

    void modifyFontTagAttr(int size);

    // Shortcuts for context menu
    QShortcut *attachFileShortcut;
    QShortcut *removeFormattingShortcut;
    QShortcut *insertQuicklinkShortcut;
    QShortcut *insertHtmlEntitiesShortcut;
    QShortcut *insertHyperlinkShortcut;
    QShortcut *encryptTextShortcut;
    QShortcut *removeHyperlinkShortcut;
    QShortcut *insertLatexShortcut;
    QShortcut *copyNoteUrlShortcut;

    FindReplace *findReplace;

    QString stripContentsForPrint();

    QString tableCellStyle;
    QString tableStyle;
    QPoint scrollPoint;

    // To record the simulated backspace button events in the undoStack.
    QVector<int> autoBackspaceIndices;


    void exitPoint(ExitPoint *exit);

    // get note title from the title UI field - and do some fixup (like discard line feeds)
    QString getCurrentNoteTitle();

    void setDirty(qint32 lid, bool dirty, bool setDateUpdated=true);
    void htmlCleanup(HtmlCleanupMode mode);
    void insertDateTimeUsingFormat(const QString &format) const;


public:
    explicit NBrowserWindow(QWidget *parent = 0);
    ~NBrowserWindow();
    QString uuid;
    NWebView *editor;
    void setContent(qint32 lid);
    NTitleEditor noteTitle;
    ReminderButton alarmButton;
    QPushButton alarmText;
    NotebookMenuButton notebookMenu;
    ExpandButton expandButton;
    UrlEditor urlEditor;
    TagEditor tagEditor;
    DateEditor dateEditor;
    //AuthorEditor authorEditor;
    //LocationEditor locationEditor;
    void setReadOnly(bool readOnly);
    //NMainMenuBar *mainMenuBarHook;
    bool isReadOnly;
    QString buildPasteUrl(QString url);
    void setEditorStyle();

    EditorButtonBar *buttonBar;
    QShortcut *focusNoteShortcut;
    QShortcut *focusTitleShortcut;
    QShortcut *insertDatetimeShortcut;
    QShortcut *insertDateShortcut;
    QShortcut *insertTimeShortcut;
    QShortcut *fontColorShortcut;
    QShortcut *fontHighlightShortcut;


    QTextEdit *printPage;
    QTextEdit *printPreviewPage;
    bool fastPrint;

    //QShortcut *leftJustifyButtonShortcut;

    QHBoxLayout line2Layout;
    QHBoxLayout line3Layout;
    qint32 lid;
    void setBackgroundColor(QString);
    void showSource(bool);
    QTextEdit *sourceEdit;
    QString sourceEditHeader;
    XmlHighlighter *highlighter;

    void tabPressed();
    void backtabPressed();
    bool enterPressed();
    void clear();
    void contentChanged();
    void printPreviewNote();
    void printNote();
    void updateResourceHash(qint32 noteLid, QByteArray oldHash, QByteArray newHash);
    void insertHtml(QString html);
    void hideHtmlEntities();

signals:
    void noteUpdated(qint32);
    qint32 tagAdded(qint32);
    void evernoteLinkClicked(qint32 lid, bool newTab, bool newWindow);

    // signal that note list at given lid/columns should update with "data"
    // passing "invalid" qvariant; this may be useful in cases where content did not changed
    // but we want to redraw
    void updateNoteList(qint32 lid, int column, QVariant data);
    void noteContentEditedSignal(QString uuid, qint32 lid, QString content);
    void noteTitleEditedSignal(QString uuid, qint32 lid, QString content);
    void noteAuthorEditedSignal(QString uuid, qint32 lid, QString content);
    void noteDateEditedSignal(QString uuid, qint32 lid, int dateID, QDateTime dt);
    void noteNotebookEditedSignal(QString uuid, qint32 lid, qint32 notebookLid, QString notebookName);
    void noteUrlEditedSignal(QString uuid, qint32 lid, QString content);
    void noteTagsEditedSignal(QString uuid, qint32 lid, QStringList names);
    void noteLocationEditedSignal(QString uuid, qint32 lid, double longitude, double latitude, double altitude, QString name);
    void noteAlarmEditedSignal(QString uuid, qint32 lid, bool strikeout, QString text);
    void showHtmlEntities();
    void setMessage(QString msg);
    void requestNoteContentUpdate(qint32, QString, bool);


public slots:
    void saveNoteContent();
    void changeExpandState(int value);
    void tagRenamed(qint32 lid, QString oldName, QString newName);
    void notebookRenamed(qint32 lid, QString oldName, QString newName);
    void tagDeleted(qint32 lid, QString name);
    void notebookDeleted(qint32 lid, QString name);
    void notebookAdded(qint32 lid);
    void addTagName(qint32 lid);
    void stackRenamed(QString oldName, QString newName);
    void stackDeleted(QString name);
    void stackAdded(QString name);
    void noteSyncUpdate(qint32 lid);
    void noteContentUpdated();
    void microFocusChanged();

    void undoButtonPressed();
    void redoButtonPressed();
    void cutButtonPressed();
    void copyButtonPressed();
    void printPreviewReady(QPrinter *printer);
    void emailNote();
    void prepareEmailMessage(MimeMessage *message, QString note);
    void pasteButtonPressed();
    void pasteWithoutFormatButtonPressed();
    void boldButtonPressed();
    void selectAllButtonPressed();
    void italicsButtonPressed();
    void underlineButtonPressed();
    void strikethroughButtonPressed();
    void superscriptButtonPressed();
    void subscriptButtonPressed();
    void alignLeftButtonPressed();
    void alignCenterButtonPressed();
    void alignFullButtonPressed();
    void alignRightButtonPressed();
    void horizontalLineButtonPressed();
    void shiftLeftButtonPressed();
    void shiftRightButtonPressed();
    void bulletListButtonPressed();
    void numberListButtonPressed();
    void todoButtonPressed();
    void fontSizeSelected(int index);
    void fontNameSelected(int index);
    void fontColorClicked();
    void fontHighlightClicked();
    void encryptButtonPressed();
    void decryptText(QString id, QString text, QString hint,  QString cipher="RC2", int len=64);
    void insertLinkButtonPressed();
    void insertQuickLinkButtonPressed();
    void removeLinkButtonPressed();
    void insertLatexButtonPressed();
    void insertTableButtonPressed();
    void insertTableRowButtonPressed();
    void insertTableColumnButtonPressed();
    void tablePropertiesButtonPressed();
    void deleteTableRowButtonPressed();
    void deleteTableColumnButtonPressed();
    void rotateImageLeftButtonPressed();
    void rotateImageRightButtonPressed();
    void removeFormatButtonPressed();
    void formatCodeButtonPressed();
    void syncButtonPressed();
    void linkClicked(const QUrl url);
    void toggleSource();
    void setSource();
    void focusTitle();
    void focusNote();
    void imageContextMenu(QString lid, QString filename);

    void insertDatetime();
    void insertDate();
    void insertTime();

    void attachFile();
    void attachFileSelected(QString filename);

    void setTableCellStyle(QString value);
    void setTableStyle(QString value);

    void exposeToJavascript();
    void boldActive();
    void italicsActive();
    void insideEncryptionArea();
    void underlineActive();
    void setInsideList();
    void setInsideTable();
    void setInsidePre();
    void noteSourceUpdated();
    void setInsideLink(QString link);
    QString fixEncryptionPaste(QString data);
    void alarmCompleted();
    void alarmSet();
    void alarmClear();
    void alarmMenuActivated();
    void removeEncryption(QString id, QString plainText, bool permanent, QString slot);
    void spellCheckPressed();
    void noteContentEdited();
    void insertHtmlEntities();
    void handleUrls(const QMimeData *mime);
    void setTableCursorPositionTab(int currentRow, int currentCol, int tableRows, int tableColumns);
    void setTableCursorPositionBackTab(int currentRow, int currentCol, int tableRows, int tableColumns);
    void changeDisplayFontSize(QString size);
    void changeDisplayFontName(QString name);
    void printNodeName(QString node);
    void sendDateCreatedUpdateSignal();
    void sendDateSubjectUpdateSignal();
    void newTagFocusShortcut();
    void authorFocusShortcut();
    void notebookFocusShortcut();
    void fontFocusShortcut();
    void fontSizeFocusShortcut();
    void urlFocusShortcut();
    void copyInAppNoteLink();
    void findShortcut();
    void findReplaceShortcut();
    void findNextShortcut();
    void findPrevShortcut();
    void findReplaceAllInNotePressed();
    void findNextInNote();
    void findPrevInNote();
    void findReplaceWindowHidden();
    void findReplaceInNotePressed();

    void htmlSimplify();


private slots:
    // Send a signal, that the note has been updated
    void sendTitleUpdateSignal();

    void sendNotebookUpdateSignal();
    void sendDateUpdateSignal(qint64 dt=0);
    void sendLocationUpdateSignal();
    void sendAuthorUpdateSignal();
    void sendTagUpdateSignal();
    void sendUrlUpdateSignal();
    void newTagAdded(qint32);
    void focusCheck();
    void saveTimeCheck();
    void browserThreadStarted();
    void repositionAfterSourceEdit(bool);
    void correctFontTagAttr();
};


#endif // NBROWSERWINDOW_H
