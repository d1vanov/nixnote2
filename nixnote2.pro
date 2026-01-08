QT += core gui widgets printsupport webkit webkitwidgets sql network xml dbus qml concurrent

DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0
unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += poppler-qt5 libcurl tidy hunspell
}

unix:!mac:LIBS += -lpthread -g -rdynamic

win32:INCLUDEPATH += "$$PWD/winlib/includes/poppler/qt5"
win32:INCLUDEPATH += "$$PWD/winlib/includes"
win32:INCLUDEPATH += "$$PWD/winlib/includes/hunspell"
win32:LIBS += -L"$$PWD/winlib" -lpoppler-qt5
win32:LIBS += -L"$$PWD/winlib" -ltidy
win32:LIBS += -L"$$PWD/winlib" -lhunspell-$$[HUNSPELL_VERSION]
win32:RC_ICONS += "$$PWD/resources/images/windowIcon.ico"

INCLUDEPATH += "$$PWD/src/qevercloud/include"
INCLUDEPATH += "$$OUT_PWD"

mac {
    TARGET = NixNote2
} else {
    TARGET = nixnote2
}
TEMPLATE = app
RESOURCES = nixnote2.qrc

UI_DIR = .

CONFIG(debug, debug|release) {
    DESTDIR = qmake-build-debug
    BUILD_TYPE = debug
    message($$TARGET: Debug build!)
} else {
    DESTDIR = qmake-build-release
    BUILD_TYPE = release
    message($$TARGET: Release build!)
    QMAKE_POST_LINK=$$QMAKE_STRIP $${DESTDIR}/$${TARGET}
}
OBJECTS_DIR = $${DESTDIR}
MOC_DIR = $${DESTDIR}

DEFINES += QEVERCLOUD_USE_SYSTEM_BROWSER=1

qevercloud_version_info.input = src/qevercloud/include/qevercloud/headers/VersionInfo.h.in
qevercloud_version_info.output = $$OUT_PWD/VersionInfo.h
QMAKE_SUBSTITUTES += qevercloud_version_info

SOURCES += \
    src/application.cpp \
    src/global.cpp \
    src/main.cpp \
    src/nixnote.cpp \
    src/cmdtools/addnote.cpp \
    src/cmdtools/alternote.cpp \
    src/cmdtools/cmdlinequery.cpp \
    src/cmdtools/cmdlinetool.cpp \
    src/cmdtools/deletenote.cpp \
    src/cmdtools/emailnote.cpp \
    src/cmdtools/extractnotes.cpp \
    src/cmdtools/extractnotetext.cpp \
    src/cmdtools/importnotes.cpp \
    src/cmdtools/signalgui.cpp \
    src/communication/communicationerror.cpp \
    src/communication/communicationmanager.cpp \
    src/dialog/aboutdialog.cpp \
    src/dialog/accountdialog.cpp \
    src/dialog/accountmaintenancedialog.cpp \
    src/dialog/adduseraccountdialog.cpp \
    src/dialog/closenotebookdialog.cpp \
    src/dialog/databasestatus.cpp \
    src/dialog/emaildialog.cpp \
    src/dialog/encryptdialog.cpp \
    src/dialog/endecryptdialog.cpp \
    src/dialog/faderdialog.cpp \
    src/dialog/htmlentitiesdialog.cpp \
    src/dialog/insertlatexdialog.cpp \
    src/dialog/insertlinkdialog.cpp \
    src/dialog/locationdialog.cpp \
    src/dialog/logindialog.cpp \
    src/dialog/notebookproperties.cpp \
    src/dialog/notehistoryselect.cpp \
    src/dialog/noteproperties.cpp \
    src/dialog/preferences/appearancepreferences.cpp \
    src/dialog/preferences/debugpreferences.cpp \
    src/dialog/preferences/emailpreferences.cpp \
    src/dialog/preferences/exitpreferences.cpp \
    src/dialog/preferences/localepreferences.cpp \
    src/dialog/preferences/preferencesdialog.cpp \
    src/dialog/preferences/searchpreferences.cpp \
    src/dialog/preferences/syncpreferences.cpp \
    src/dialog/preferences/thumbnailpreferences.cpp \
    src/dialog/remindersetdialog.cpp \
    src/dialog/savedsearchproperties.cpp \
    src/dialog/shortcutdialog.cpp \
    src/dialog/spellcheckdialog.cpp \
    src/dialog/tabledialog.cpp \
    src/dialog/tagproperties.cpp \
    src/dialog/watchfolderadd.cpp \
    src/dialog/watchfolderdialog.cpp \
    src/email/emailaddress.cpp \
    src/email/mimeattachment.cpp \
    src/email/mimecontentformatter.cpp \
    src/email/mimefile.cpp \
    src/email/mimehtml.cpp \
    src/email/mimeinlinefile.cpp \
    src/email/mimemessage.cpp \
    src/email/mimemultipart.cpp \
    src/email/mimepart.cpp \
    src/email/mimetext.cpp \
    src/email/quotedprintable.cpp \
    src/email/smtpclient.cpp \
    src/exits/exitmanager.cpp \
    src/exits/exitpoint.cpp \
    src/filters/filtercriteria.cpp \
    src/filters/filterengine.cpp \
    src/filters/notesortfilterproxymodel.cpp \
    src/filters/remotequery.cpp \
    src/gui/browserWidgets/authoreditor.cpp \
    src/gui/browserWidgets/colormenu.cpp \
    src/gui/browserWidgets/dateeditor.cpp \
    src/gui/browserWidgets/datetimeeditor.cpp \
    src/gui/browserWidgets/editorbuttonbar.cpp \
    src/gui/browserWidgets/expandbutton.cpp \
    src/gui/browserWidgets/fontnamecombobox.cpp \
    src/gui/browserWidgets/fontsizecombobox.cpp \
    src/gui/browserWidgets/locationeditor.cpp \
    src/gui/browserWidgets/notebookmenubutton.cpp \
    src/gui/browserWidgets/ntitleeditor.cpp \
    src/gui/browserWidgets/reminderbutton.cpp \
    src/gui/browserWidgets/table/tablepropertiesdialog.cpp \
    src/gui/browserWidgets/tageditor.cpp \
    src/gui/browserWidgets/tageditornewtag.cpp \
    src/gui/browserWidgets/tagviewer.cpp \
    src/gui/browserWidgets/urleditor.cpp \
    src/gui/datedelegate.cpp \
    src/gui/externalbrowse.cpp \
    src/gui/favoritesview.cpp \
    src/gui/favoritesviewdelegate.cpp \
    src/gui/favoritesviewitem.cpp \
    src/gui/findreplace.cpp \
    src/gui/flowlayout.cpp \
    src/gui/imagedelegate.cpp \
    src/gui/lineedit.cpp \
    src/gui/nattributetree.cpp \
    src/gui/nbrowserwindow.cpp \
    src/gui/nmainmenubar.cpp \
    src/gui/nnotebookview.cpp \
    src/gui/nnotebookviewdelegate.cpp \
    src/gui/nnotebookviewitem.cpp \
    src/gui/nsearchview.cpp \
    src/gui/nsearchviewitem.cpp \
    src/gui/ntableview.cpp \
    src/gui/ntableviewheader.cpp \
    src/gui/ntabwidget.cpp \
    src/gui/ntagview.cpp \
    src/gui/ntagviewdelegate.cpp \
    src/gui/ntagviewitem.cpp \
    src/gui/ntrashtree.cpp \
    src/gui/ntrashviewdelegate.cpp \
    src/gui/numberdelegate.cpp \
    src/gui/nwebpage.cpp \
    src/gui/nwebview.cpp \
    src/gui/plugins/pluginfactory.cpp \
    src/gui/plugins/popplergraphicsview.cpp \
    src/gui/plugins/popplerviewer.cpp \
    src/gui/reminderorderdelegate.cpp \
    src/gui/shortcutkeys.cpp \
    src/gui/traymenu.cpp \
    src/gui/treewidgeteditor.cpp \
    src/gui/truefalsedelegate.cpp \
    src/gui/widgetpanel.cpp \
    src/logger/qsdebugoutput.cpp \
    src/logger/qslog.cpp \
    src/logger/qslogdest.cpp \
    src/models/notecache.cpp \
    src/models/notemodel.cpp \
    src/models/ntreemodel.cpp \
    src/oauth/oauthtokenizer.cpp \
    src/hunspell/spellchecker.cpp \
	src/qevercloud/src/DurableService.cpp \
	src/qevercloud/src/EventLoopFinisher.cpp \
	src/qevercloud/src/Http.cpp \
	src/qevercloud/src/HttpRequestParser.cpp \
	src/qevercloud/src/HttpUtils.cpp \
	src/qevercloud/src/IInkNoteImageDownloader.cpp \
	src/qevercloud/src/INoteThumbnailDownloader.cpp \
	src/qevercloud/src/Impl.cpp \
	src/qevercloud/src/InkNoteImageDownloader.cpp \
	src/qevercloud/src/IRequestContext.cpp \
	src/qevercloud/src/Log.cpp \
	src/qevercloud/src/NetworkProxy.cpp \
	src/qevercloud/src/NetworkReplyFetcher.cpp \
	src/qevercloud/src/NoteThumbnailDownloader.cpp \
	src/qevercloud/src/NoteThumbnailDownloader.h \
	src/qevercloud/src/Printable.cpp \
	src/qevercloud/src/RequestContext.cpp \
	src/qevercloud/src/RequestContextBuilder.cpp \
	src/qevercloud/src/VersionInfo.cpp \
	src/qevercloud/src/Constants.cpp \
	src/qevercloud/src/EDAMErrorCode.cpp \
	src/qevercloud/src/exceptions/EDAMInvalidContactsException.cpp \
	src/qevercloud/src/exceptions/EDAMNotFoundException.cpp \
	src/qevercloud/src/exceptions/EDAMSystemException.cpp \
	src/qevercloud/src/exceptions/EDAMSystemExceptionAuthExpired.cpp \
	src/qevercloud/src/exceptions/EDAMSystemExceptionRateLimitReached.cpp \
	src/qevercloud/src/exceptions/EDAMUserException.cpp \
	src/qevercloud/src/exceptions/EverCloudException.cpp \
	src/qevercloud/src/exceptions/EvernoteException.cpp \
	src/qevercloud/src/exceptions/NetworkException.cpp \
	src/qevercloud/src/exceptions/ThriftException.cpp \
    src/qevercloud/src/exceptions/builders/EDAMInvalidContactsExceptionBuilder.cpp \
    src/qevercloud/src/exceptions/builders/EDAMNotFoundExceptionBuilder.cpp \
    src/qevercloud/src/exceptions/builders/EDAMSystemExceptionBuilder.cpp \
    src/qevercloud/src/exceptions/builders/EDAMUserExceptionBuilder.cpp \
	src/qevercloud/src/exceptions/impl/EDAMInvalidContactsExceptionImpl.cpp \
	src/qevercloud/src/exceptions/impl/EDAMNotFoundExceptionImpl.cpp \
	src/qevercloud/src/exceptions/impl/EDAMSystemExceptionImpl.cpp \
	src/qevercloud/src/exceptions/impl/EDAMUserExceptionImpl.cpp \
	src/qevercloud/src/serialization/json/Accounting.cpp \
	src/qevercloud/src/serialization/json/AccountLimits.cpp \
	src/qevercloud/src/serialization/json/AuthenticationResult.cpp \
	src/qevercloud/src/serialization/json/BootstrapInfo.cpp \
	src/qevercloud/src/serialization/json/BootstrapProfile.cpp \
	src/qevercloud/src/serialization/json/BootstrapSettings.cpp \
	src/qevercloud/src/serialization/json/BusinessInvitation.cpp \
	src/qevercloud/src/serialization/json/BusinessNotebook.cpp \
	src/qevercloud/src/serialization/json/BusinessUserAttributes.cpp \
	src/qevercloud/src/serialization/json/BusinessUserInfo.cpp \
	src/qevercloud/src/serialization/json/CanMoveToContainerRestrictions.cpp \
	src/qevercloud/src/serialization/json/Contact.cpp \
	src/qevercloud/src/serialization/json/CreateOrUpdateNotebookSharesResult.cpp \
	src/qevercloud/src/serialization/json/Data.cpp \
	src/qevercloud/src/serialization/json/EDAMInvalidContactsException.cpp \
	src/qevercloud/src/serialization/json/EDAMNotFoundException.cpp \
	src/qevercloud/src/serialization/json/EDAMSystemException.cpp \
	src/qevercloud/src/serialization/json/EDAMUserException.cpp \
	src/qevercloud/src/serialization/json/Identity.cpp \
	src/qevercloud/src/serialization/json/InvitationShareRelationship.cpp \
	src/qevercloud/src/serialization/json/LazyMap.cpp \
	src/qevercloud/src/serialization/json/LinkedNotebook.cpp \
	src/qevercloud/src/serialization/json/ManageNotebookSharesError.cpp \
	src/qevercloud/src/serialization/json/ManageNotebookSharesParameters.cpp \
	src/qevercloud/src/serialization/json/ManageNotebookSharesResult.cpp \
	src/qevercloud/src/serialization/json/ManageNoteSharesError.cpp \
	src/qevercloud/src/serialization/json/ManageNoteSharesParameters.cpp \
	src/qevercloud/src/serialization/json/ManageNoteSharesResult.cpp \
	src/qevercloud/src/serialization/json/MemberShareRelationship.cpp \
	src/qevercloud/src/serialization/json/Note.cpp \
	src/qevercloud/src/serialization/json/NoteAttributes.cpp \
	src/qevercloud/src/serialization/json/Notebook.cpp \
	src/qevercloud/src/serialization/json/NotebookDescriptor.cpp \
	src/qevercloud/src/serialization/json/NotebookRecipientSettings.cpp \
	src/qevercloud/src/serialization/json/NotebookRestrictions.cpp \
	src/qevercloud/src/serialization/json/NotebookShareTemplate.cpp \
	src/qevercloud/src/serialization/json/NoteCollectionCounts.cpp \
	src/qevercloud/src/serialization/json/NoteEmailParameters.cpp \
	src/qevercloud/src/serialization/json/NoteFilter.cpp \
	src/qevercloud/src/serialization/json/NoteInvitationShareRelationship.cpp \
	src/qevercloud/src/serialization/json/NoteLimits.cpp \
	src/qevercloud/src/serialization/json/NoteList.cpp \
	src/qevercloud/src/serialization/json/NoteMemberShareRelationship.cpp \
	src/qevercloud/src/serialization/json/NoteMetadata.cpp \
	src/qevercloud/src/serialization/json/NoteRestrictions.cpp \
	src/qevercloud/src/serialization/json/NoteResultSpec.cpp \
	src/qevercloud/src/serialization/json/NoteShareRelationshipRestrictions.cpp \
	src/qevercloud/src/serialization/json/NoteShareRelationships.cpp \
	src/qevercloud/src/serialization/json/NotesMetadataList.cpp \
	src/qevercloud/src/serialization/json/NotesMetadataResultSpec.cpp \
	src/qevercloud/src/serialization/json/NoteVersionId.cpp \
	src/qevercloud/src/serialization/json/PublicUserInfo.cpp \
	src/qevercloud/src/serialization/json/Publishing.cpp \
	src/qevercloud/src/serialization/json/RelatedContent.cpp \
	src/qevercloud/src/serialization/json/RelatedContentImage.cpp \
	src/qevercloud/src/serialization/json/RelatedQuery.cpp \
	src/qevercloud/src/serialization/json/RelatedResult.cpp \
	src/qevercloud/src/serialization/json/RelatedResultSpec.cpp \
	src/qevercloud/src/serialization/json/Resource.cpp \
	src/qevercloud/src/serialization/json/ResourceAttributes.cpp \
	src/qevercloud/src/serialization/json/SavedSearch.cpp \
	src/qevercloud/src/serialization/json/SavedSearchScope.cpp \
	src/qevercloud/src/serialization/json/SharedNote.cpp \
	src/qevercloud/src/serialization/json/SharedNotebook.cpp \
	src/qevercloud/src/serialization/json/SharedNotebookRecipientSettings.cpp \
	src/qevercloud/src/serialization/json/SharedNoteTemplate.cpp \
	src/qevercloud/src/serialization/json/ShareRelationshipRestrictions.cpp \
	src/qevercloud/src/serialization/json/ShareRelationships.cpp \
	src/qevercloud/src/serialization/json/SyncChunk.cpp \
	src/qevercloud/src/serialization/json/SyncChunkFilter.cpp \
	src/qevercloud/src/serialization/json/SyncState.cpp \
	src/qevercloud/src/serialization/json/Tag.cpp \
	src/qevercloud/src/serialization/json/UpdateNoteIfUsnMatchesResult.cpp \
	src/qevercloud/src/serialization/json/User.cpp \
	src/qevercloud/src/serialization/json/UserAttributes.cpp \
	src/qevercloud/src/serialization/json/UserIdentity.cpp \
	src/qevercloud/src/serialization/json/UserProfile.cpp \
	src/qevercloud/src/serialization/json/UserUrls.cpp \
	src/qevercloud/src/services/NoteStore.cpp \
	src/qevercloud/src/services/NoteStoreServer.cpp \
	src/qevercloud/src/services/UserStore.cpp \
	src/qevercloud/src/services/UserStoreServer.cpp \
	src/qevercloud/src/types/Accounting.cpp \
	src/qevercloud/src/types/AccountLimits.cpp \
	src/qevercloud/src/types/AuthenticationResult.cpp \
	src/qevercloud/src/types/BootstrapInfo.cpp \
	src/qevercloud/src/types/BootstrapProfile.cpp \
	src/qevercloud/src/types/BootstrapSettings.cpp \
	src/qevercloud/src/types/BusinessInvitation.cpp \
	src/qevercloud/src/types/BusinessNotebook.cpp \
	src/qevercloud/src/types/BusinessUserAttributes.cpp \
	src/qevercloud/src/types/BusinessUserInfo.cpp \
	src/qevercloud/src/types/CanMoveToContainerRestrictions.cpp \
	src/qevercloud/src/types/Contact.cpp \
	src/qevercloud/src/types/CreateOrUpdateNotebookSharesResult.cpp \
	src/qevercloud/src/types/Data.cpp \
	src/qevercloud/src/types/Identity.cpp \
	src/qevercloud/src/types/InvitationShareRelationship.cpp \
	src/qevercloud/src/types/LazyMap.cpp \
	src/qevercloud/src/types/LinkedNotebook.cpp \
	src/qevercloud/src/types/ManageNotebookSharesError.cpp \
	src/qevercloud/src/types/ManageNotebookSharesParameters.cpp \
	src/qevercloud/src/types/ManageNotebookSharesResult.cpp \
	src/qevercloud/src/types/ManageNoteSharesError.cpp \
	src/qevercloud/src/types/ManageNoteSharesParameters.cpp \
	src/qevercloud/src/types/ManageNoteSharesResult.cpp \
	src/qevercloud/src/types/MemberShareRelationship.cpp \
	src/qevercloud/src/types/Metatypes.cpp \
	src/qevercloud/src/types/Note.cpp \
	src/qevercloud/src/types/NoteAttributes.cpp \
	src/qevercloud/src/types/Notebook.cpp \
	src/qevercloud/src/types/NotebookDescriptor.cpp \
	src/qevercloud/src/types/NotebookRecipientSettings.cpp \
	src/qevercloud/src/types/NotebookRestrictions.cpp \
	src/qevercloud/src/types/NotebookShareTemplate.cpp \
	src/qevercloud/src/types/NoteCollectionCounts.cpp \
	src/qevercloud/src/types/NoteEmailParameters.cpp \
	src/qevercloud/src/types/NoteFilter.cpp \
	src/qevercloud/src/types/NoteInvitationShareRelationship.cpp \
	src/qevercloud/src/types/NoteLimits.cpp \
	src/qevercloud/src/types/NoteList.cpp \
	src/qevercloud/src/types/NoteMemberShareRelationship.cpp \
	src/qevercloud/src/types/NoteMetadata.cpp \
	src/qevercloud/src/types/NoteRestrictions.cpp \
	src/qevercloud/src/types/NoteResultSpec.cpp \
	src/qevercloud/src/types/NoteShareRelationshipRestrictions.cpp \
	src/qevercloud/src/types/NoteShareRelationships.cpp \
	src/qevercloud/src/types/NotesMetadataList.cpp \
	src/qevercloud/src/types/NotesMetadataResultSpec.cpp \
	src/qevercloud/src/types/NoteVersionId.cpp \
	src/qevercloud/src/types/PublicUserInfo.cpp \
	src/qevercloud/src/types/Publishing.cpp \
	src/qevercloud/src/types/RelatedContent.cpp \
	src/qevercloud/src/types/RelatedContentImage.cpp \
	src/qevercloud/src/types/RelatedQuery.cpp \
	src/qevercloud/src/types/RelatedResult.cpp \
	src/qevercloud/src/types/RelatedResultSpec.cpp \
	src/qevercloud/src/types/Resource.cpp \
	src/qevercloud/src/types/ResourceAttributes.cpp \
	src/qevercloud/src/types/SavedSearch.cpp \
	src/qevercloud/src/types/SavedSearchScope.cpp \
	src/qevercloud/src/types/SharedNote.cpp \
	src/qevercloud/src/types/SharedNotebook.cpp \
	src/qevercloud/src/types/SharedNotebookRecipientSettings.cpp \
	src/qevercloud/src/types/SharedNoteTemplate.cpp \
	src/qevercloud/src/types/ShareRelationshipRestrictions.cpp \
	src/qevercloud/src/types/ShareRelationships.cpp \
	src/qevercloud/src/types/SyncChunk.cpp \
	src/qevercloud/src/types/SyncChunkFilter.cpp \
	src/qevercloud/src/types/SyncState.cpp \
	src/qevercloud/src/types/Tag.cpp \
	src/qevercloud/src/types/Types_io.cpp \
	src/qevercloud/src/types/UpdateNoteIfUsnMatchesResult.cpp \
	src/qevercloud/src/types/User.cpp \
	src/qevercloud/src/types/UserAttributes.cpp \
	src/qevercloud/src/types/UserIdentity.cpp \
	src/qevercloud/src/types/UserProfile.cpp \
	src/qevercloud/src/types/UserUrls.cpp \
    src/qevercloud/src/types/builders/AccountingBuilder.cpp \
    src/qevercloud/src/types/builders/AccountLimitsBuilder.cpp \
    src/qevercloud/src/types/builders/AuthenticationResultBuilder.cpp \
    src/qevercloud/src/types/builders/BootstrapInfoBuilder.cpp \
    src/qevercloud/src/types/builders/BootstrapProfileBuilder.cpp \
    src/qevercloud/src/types/builders/BootstrapSettingsBuilder.cpp \
    src/qevercloud/src/types/builders/BusinessInvitationBuilder.cpp \
    src/qevercloud/src/types/builders/BusinessNotebookBuilder.cpp \
    src/qevercloud/src/types/builders/BusinessUserAttributesBuilder.cpp \
    src/qevercloud/src/types/builders/BusinessUserInfoBuilder.cpp \
    src/qevercloud/src/types/builders/CanMoveToContainerRestrictionsBuilder.cpp \
    src/qevercloud/src/types/builders/ContactBuilder.cpp \
    src/qevercloud/src/types/builders/CreateOrUpdateNotebookSharesResultBuilder.cpp \
    src/qevercloud/src/types/builders/DataBuilder.cpp \
    src/qevercloud/src/types/builders/IdentityBuilder.cpp \
    src/qevercloud/src/types/builders/InvitationShareRelationshipBuilder.cpp \
    src/qevercloud/src/types/builders/LazyMapBuilder.cpp \
    src/qevercloud/src/types/builders/LinkedNotebookBuilder.cpp \
    src/qevercloud/src/types/builders/ManageNotebookSharesErrorBuilder.cpp \
    src/qevercloud/src/types/builders/ManageNotebookSharesParametersBuilder.cpp \
    src/qevercloud/src/types/builders/ManageNotebookSharesResultBuilder.cpp \
    src/qevercloud/src/types/builders/ManageNoteSharesErrorBuilder.cpp \
    src/qevercloud/src/types/builders/ManageNoteSharesParametersBuilder.cpp \
    src/qevercloud/src/types/builders/ManageNoteSharesResultBuilder.cpp \
    src/qevercloud/src/types/builders/MemberShareRelationshipBuilder.cpp \
    src/qevercloud/src/types/builders/NoteAttributesBuilder.cpp \
    src/qevercloud/src/types/builders/NotebookBuilder.cpp \
    src/qevercloud/src/types/builders/NotebookDescriptorBuilder.cpp \
    src/qevercloud/src/types/builders/NotebookRecipientSettingsBuilder.cpp \
    src/qevercloud/src/types/builders/NotebookRestrictionsBuilder.cpp \
    src/qevercloud/src/types/builders/NotebookShareTemplateBuilder.cpp \
    src/qevercloud/src/types/builders/NoteBuilder.cpp \
    src/qevercloud/src/types/builders/NoteCollectionCountsBuilder.cpp \
    src/qevercloud/src/types/builders/NoteEmailParametersBuilder.cpp \
    src/qevercloud/src/types/builders/NoteFilterBuilder.cpp \
    src/qevercloud/src/types/builders/NoteInvitationShareRelationshipBuilder.cpp \
    src/qevercloud/src/types/builders/NoteLimitsBuilder.cpp \
    src/qevercloud/src/types/builders/NoteListBuilder.cpp \
    src/qevercloud/src/types/builders/NoteMemberShareRelationshipBuilder.cpp \
    src/qevercloud/src/types/builders/NoteMetadataBuilder.cpp \
    src/qevercloud/src/types/builders/NoteRestrictionsBuilder.cpp \
    src/qevercloud/src/types/builders/NoteResultSpecBuilder.cpp \
    src/qevercloud/src/types/builders/NoteShareRelationshipRestrictionsBuilder.cpp \
    src/qevercloud/src/types/builders/NoteShareRelationshipsBuilder.cpp \
    src/qevercloud/src/types/builders/NotesMetadataListBuilder.cpp \
    src/qevercloud/src/types/builders/NotesMetadataResultSpecBuilder.cpp \
    src/qevercloud/src/types/builders/NoteVersionIdBuilder.cpp \
    src/qevercloud/src/types/builders/PublicUserInfoBuilder.cpp \
    src/qevercloud/src/types/builders/PublishingBuilder.cpp \
    src/qevercloud/src/types/builders/RelatedContentBuilder.cpp \
    src/qevercloud/src/types/builders/RelatedContentImageBuilder.cpp \
    src/qevercloud/src/types/builders/RelatedQueryBuilder.cpp \
    src/qevercloud/src/types/builders/RelatedResultBuilder.cpp \
    src/qevercloud/src/types/builders/RelatedResultSpecBuilder.cpp \
    src/qevercloud/src/types/builders/ResourceAttributesBuilder.cpp \
    src/qevercloud/src/types/builders/ResourceBuilder.cpp \
    src/qevercloud/src/types/builders/SavedSearchBuilder.cpp \
    src/qevercloud/src/types/builders/SavedSearchScopeBuilder.cpp \
    src/qevercloud/src/types/builders/SharedNotebookBuilder.cpp \
    src/qevercloud/src/types/builders/SharedNotebookRecipientSettingsBuilder.cpp \
    src/qevercloud/src/types/builders/SharedNoteBuilder.cpp \
    src/qevercloud/src/types/builders/SharedNoteTemplateBuilder.cpp \
    src/qevercloud/src/types/builders/ShareRelationshipRestrictionsBuilder.cpp \
    src/qevercloud/src/types/builders/ShareRelationshipsBuilder.cpp \
    src/qevercloud/src/types/builders/SyncChunkBuilder.cpp \
    src/qevercloud/src/types/builders/SyncChunkFilterBuilder.cpp \
    src/qevercloud/src/types/builders/SyncStateBuilder.cpp \
    src/qevercloud/src/types/builders/TagBuilder.cpp \
    src/qevercloud/src/types/builders/UpdateNoteIfUsnMatchesResultBuilder.cpp \
    src/qevercloud/src/types/builders/UserAttributesBuilder.cpp \
    src/qevercloud/src/types/builders/UserBuilder.cpp \
    src/qevercloud/src/types/builders/UserIdentityBuilder.cpp \
    src/qevercloud/src/types/builders/UserProfileBuilder.cpp \
    src/qevercloud/src/types/builders/UserUrlsBuilder.cpp \
	src/qevercloud/src/types/impl/AccountingImpl.cpp \
	src/qevercloud/src/types/impl/AccountLimitsImpl.cpp \
	src/qevercloud/src/types/impl/AuthenticationResultImpl.cpp \
	src/qevercloud/src/types/impl/BootstrapInfoImpl.cpp \
	src/qevercloud/src/types/impl/BootstrapProfileImpl.cpp \
	src/qevercloud/src/types/impl/BootstrapSettingsImpl.cpp \
	src/qevercloud/src/types/impl/BusinessInvitationImpl.cpp \
	src/qevercloud/src/types/impl/BusinessNotebookImpl.cpp \
	src/qevercloud/src/types/impl/BusinessUserAttributesImpl.cpp \
	src/qevercloud/src/types/impl/BusinessUserInfoImpl.cpp \
	src/qevercloud/src/types/impl/CanMoveToContainerRestrictionsImpl.cpp \
	src/qevercloud/src/types/impl/ContactImpl.cpp \
	src/qevercloud/src/types/impl/CreateOrUpdateNotebookSharesResultImpl.cpp \
	src/qevercloud/src/types/impl/DataImpl.cpp \
	src/qevercloud/src/types/impl/IdentityImpl.cpp \
	src/qevercloud/src/types/impl/InvitationShareRelationshipImpl.cpp \
	src/qevercloud/src/types/impl/LazyMapImpl.cpp \
	src/qevercloud/src/types/impl/LinkedNotebookImpl.cpp \
	src/qevercloud/src/types/impl/ManageNotebookSharesErrorImpl.cpp \
	src/qevercloud/src/types/impl/ManageNotebookSharesParametersImpl.cpp \
	src/qevercloud/src/types/impl/ManageNotebookSharesResultImpl.cpp \
	src/qevercloud/src/types/impl/ManageNoteSharesErrorImpl.cpp \
	src/qevercloud/src/types/impl/ManageNoteSharesParametersImpl.cpp \
	src/qevercloud/src/types/impl/ManageNoteSharesResultImpl.cpp \
	src/qevercloud/src/types/impl/MemberShareRelationshipImpl.cpp \
	src/qevercloud/src/types/impl/NoteAttributesImpl.cpp \
	src/qevercloud/src/types/impl/NotebookImpl.cpp \
	src/qevercloud/src/types/impl/NotebookDescriptorImpl.cpp \
	src/qevercloud/src/types/impl/NotebookRecipientSettingsImpl.cpp \
	src/qevercloud/src/types/impl/NotebookRestrictionsImpl.cpp \
	src/qevercloud/src/types/impl/NotebookShareTemplateImpl.cpp \
	src/qevercloud/src/types/impl/NoteCollectionCountsImpl.cpp \
	src/qevercloud/src/types/impl/NoteImpl.cpp \
	src/qevercloud/src/types/impl/NoteEmailParametersImpl.cpp \
	src/qevercloud/src/types/impl/NoteFilterImpl.cpp \
	src/qevercloud/src/types/impl/NoteInvitationShareRelationshipImpl.cpp \
	src/qevercloud/src/types/impl/NoteLimitsImpl.cpp \
	src/qevercloud/src/types/impl/NoteListImpl.cpp \
	src/qevercloud/src/types/impl/NoteMemberShareRelationshipImpl.cpp \
	src/qevercloud/src/types/impl/NoteMetadataImpl.cpp \
	src/qevercloud/src/types/impl/NoteRestrictionsImpl.cpp \
	src/qevercloud/src/types/impl/NoteResultSpecImpl.cpp \
	src/qevercloud/src/types/impl/NoteShareRelationshipRestrictionsImpl.cpp \
	src/qevercloud/src/types/impl/NoteShareRelationshipsImpl.cpp \
	src/qevercloud/src/types/impl/NotesMetadataListImpl.cpp \
	src/qevercloud/src/types/impl/NotesMetadataResultSpecImpl.cpp \
	src/qevercloud/src/types/impl/NoteVersionIdImpl.cpp \
	src/qevercloud/src/types/impl/PublicUserInfoImpl.cpp \
	src/qevercloud/src/types/impl/PublishingImpl.cpp \
	src/qevercloud/src/types/impl/RelatedContentImpl.cpp \
	src/qevercloud/src/types/impl/RelatedContentImageImpl.cpp \
	src/qevercloud/src/types/impl/RelatedQueryImpl.cpp \
	src/qevercloud/src/types/impl/RelatedResultImpl.cpp \
	src/qevercloud/src/types/impl/RelatedResultSpecImpl.cpp \
	src/qevercloud/src/types/impl/ResourceAttributesImpl.cpp \
	src/qevercloud/src/types/impl/ResourceImpl.cpp \
	src/qevercloud/src/types/impl/SavedSearchImpl.cpp \
	src/qevercloud/src/types/impl/SavedSearchScopeImpl.cpp \
	src/qevercloud/src/types/impl/SharedNotebookImpl.cpp \
	src/qevercloud/src/types/impl/SharedNotebookRecipientSettingsImpl.cpp \
	src/qevercloud/src/types/impl/SharedNoteImpl.cpp \
	src/qevercloud/src/types/impl/SharedNoteTemplateImpl.cpp \
	src/qevercloud/src/types/impl/ShareRelationshipRestrictionsImpl.cpp \
	src/qevercloud/src/types/impl/ShareRelationshipsImpl.cpp \
	src/qevercloud/src/types/impl/SyncChunkImpl.cpp \
	src/qevercloud/src/types/impl/SyncChunkFilterImpl.cpp \
	src/qevercloud/src/types/impl/SyncStateImpl.cpp \
	src/qevercloud/src/types/impl/TagImpl.cpp \
	src/qevercloud/src/types/impl/UpdateNoteIfUsnMatchesResultImpl.cpp \
	src/qevercloud/src/types/impl/UserAttributesImpl.cpp \
	src/qevercloud/src/types/impl/UserImpl.cpp \
	src/qevercloud/src/types/impl/UserIdentityImpl.cpp \
	src/qevercloud/src/types/impl/UserProfileImpl.cpp \
	src/qevercloud/src/types/impl/UserUrlsImpl.cpp \
	src/qevercloud/src/oauth/AbstractOAuthEngine.cpp \
	src/qevercloud/src/oauth/OAuth.cpp \
	src/qevercloud/src/oauth/Utils.cpp \
	src/qevercloud/src/oauth/OAuthSystemBrowser.cpp \
    src/reminders/reminderevent.cpp \
    src/reminders/remindermanager.cpp \
    src/settings/accountsmanager.cpp \
    src/settings/colorsettings.cpp \
    src/settings/filemanager.cpp \
    src/settings/startupconfig.cpp \
    src/sql/configstore.cpp \
    src/sql/databaseconnection.cpp \
    src/sql/databaseupgrade.cpp \
    src/sql/datastore.cpp \
    src/sql/favoritesrecord.cpp \
    src/sql/favoritestable.cpp \
    src/sql/filewatchertable.cpp \
    src/sql/linkednotebooktable.cpp \
    src/sql/notebooktable.cpp \
    src/sql/notemetadata.cpp \
    src/sql/notetable.cpp \
    src/sql/nsqlquery.cpp \
    src/sql/resourcetable.cpp \
    src/sql/searchtable.cpp \
    src/sql/sharednotebooktable.cpp \
    src/sql/tagtable.cpp \
    src/sql/usertable.cpp \
    src/html/attachmenticonbuilder.cpp \
    src/html/enmlformatter.cpp \
    src/html/NoteFormatterBase.cpp \
    src/html/noteformatter.cpp \
    src/html/tagscanner.cpp \
    src/html/thumbnailer.cpp \
    src/threads/browserrunner.cpp \
    src/threads/counterrunner.cpp \
    src/threads/indexrunner.cpp \
    src/threads/syncrunner.cpp \
    src/utilities/crossmemorymapper.cpp \
    src/utilities/debugtool.cpp \
    src/utilities/encrypt.cpp \
    src/utilities/mimereference.cpp \
    src/utilities/noteindexer.cpp \
    src/utilities/nuuid.cpp \
    src/utilities/pixelconverter.cpp \
    src/utilities/NixnoteStringUtils.cpp \
    src/watcher/filewatcher.cpp \
    src/watcher/filewatchermanager.cpp \
    src/xml/batchimport.cpp \
    src/xml/exportdata.cpp \
    src/xml/importdata.cpp \
    src/xml/importenex.cpp \
    src/xml/xmlhighlighter.cpp \
    src/quentier/utility/StringUtils.cpp \
    src/quentier/utility/StringUtils_p.cpp

HEADERS  += \
    src/application.h \
    src/nixnote.h \
    src/global.h \
    src/cmdtools/addnote.h \
    src/cmdtools/alternote.h \
    src/cmdtools/cmdlinequery.h \
    src/cmdtools/cmdlinetool.h \
    src/cmdtools/deletenote.h \
    src/cmdtools/emailnote.h \
    src/cmdtools/extractnotes.h \
    src/cmdtools/extractnotetext.h \
    src/cmdtools/importnotes.h \
    src/cmdtools/signalgui.h \
    src/communication/communicationerror.h \
    src/communication/communicationmanager.h \
    src/dialog/aboutdialog.h \
    src/dialog/accountdialog.h \
    src/dialog/accountmaintenancedialog.h \
    src/dialog/adduseraccountdialog.h \
    src/dialog/closenotebookdialog.h \
    src/dialog/databasestatus.h \
    src/dialog/emaildialog.h \
    src/dialog/encryptdialog.h \
    src/dialog/endecryptdialog.h \
    src/dialog/faderdialog.h \
    src/dialog/htmlentitiesdialog.h \
    src/dialog/insertlatexdialog.h \
    src/dialog/insertlinkdialog.h \
    src/dialog/locationdialog.h \
    src/dialog/logindialog.h \
    src/dialog/notebookproperties.h \
    src/dialog/notehistoryselect.h \
    src/dialog/noteproperties.h \
    src/dialog/preferences/appearancepreferences.h \
    src/dialog/preferences/debugpreferences.h \
    src/dialog/preferences/emailpreferences.h \
    src/dialog/preferences/exitpreferences.h \
    src/dialog/preferences/localepreferences.h \
    src/dialog/preferences/preferencesdialog.h \
    src/dialog/preferences/searchpreferences.h \
    src/dialog/preferences/syncpreferences.h \
    src/dialog/preferences/thumbnailpreferences.h \
    src/dialog/remindersetdialog.h \
    src/dialog/savedsearchproperties.h \
    src/dialog/shortcutdialog.h \
    src/dialog/spellcheckdialog.h \
    src/dialog/tabledialog.h \
    src/dialog/tagproperties.h \
    src/dialog/watchfolderadd.h \
    src/dialog/watchfolderdialog.h \
    src/email/emailaddress.h \
    src/email/mimeattachment.h \
    src/email/mimecontentformatter.h \
    src/email/mimefile.h \
    src/email/mimehtml.h \
    src/email/mimeinlinefile.h \
    src/email/mimemessage.h \
    src/email/mimemultipart.h \
    src/email/mimepart.h \
    src/email/mimetext.h \
    src/email/quotedprintable.h \
    src/email/smtpclient.h \
    src/email/smtpexports.h \
    src/exits/exitmanager.h \
    src/exits/exitpoint.h \
    src/filters/filtercriteria.h \
    src/filters/filterengine.h \
    src/filters/notesortfilterproxymodel.h \
    src/filters/remotequery.h \
    src/gui/browserWidgets/authoreditor.h \
    src/gui/browserWidgets/colormenu.h \
    src/gui/browserWidgets/dateeditor.h \
    src/gui/browserWidgets/datetimeeditor.h \
    src/gui/browserWidgets/editorbuttonbar.h \
    src/gui/browserWidgets/expandbutton.h \
    src/gui/browserWidgets/fontnamecombobox.h \
    src/gui/browserWidgets/fontsizecombobox.h \
    src/gui/browserWidgets/locationeditor.h \
    src/gui/browserWidgets/notebookmenubutton.h \
    src/gui/browserWidgets/ntitleeditor.h \
    src/gui/browserWidgets/reminderbutton.h \
    src/gui/browserWidgets/table/tablepropertiesdialog.h \
    src/gui/browserWidgets/tageditor.h \
    src/gui/browserWidgets/tageditornewtag.h \
    src/gui/browserWidgets/tagviewer.h \
    src/gui/browserWidgets/urleditor.h \
    src/gui/datedelegate.h \
    src/gui/externalbrowse.h \
    src/gui/favoritesview.h \
    src/gui/favoritesviewdelegate.h \
    src/gui/favoritesviewitem.h \
    src/gui/findreplace.h \
    src/gui/flowlayout.h \
    src/gui/imagedelegate.h \
    src/gui/lineedit.h \
    src/gui/nattributetree.h \
    src/gui/nbrowserwindow.h \
    src/gui/nmainmenubar.h \
    src/gui/nnotebookview.h \
    src/gui/nnotebookviewdelegate.h \
    src/gui/nnotebookviewitem.h \
    src/gui/nsearchview.h \
    src/gui/nsearchviewitem.h \
    src/gui/ntableview.h \
    src/gui/ntableviewheader.h \
    src/gui/ntabwidget.h \
    src/gui/ntagview.h \
    src/gui/ntagviewdelegate.h \
    src/gui/ntagviewitem.h \
    src/gui/ntrashtree.h \
    src/gui/ntrashviewdelegate.h \
    src/gui/numberdelegate.h \
    src/gui/nwebpage.h \
    src/gui/nwebview.h \
    src/gui/plugins/pluginfactory.h \
    src/gui/plugins/popplergraphicsview.h \
    src/gui/plugins/popplerviewer.h \
    src/gui/reminderorderdelegate.h \
    src/gui/shortcutkeys.h \
    src/gui/traymenu.h \
    src/gui/treewidgeteditor.h \
    src/gui/truefalsedelegate.h \
    src/gui/widgetpanel.h \
    src/logger/qsdebugoutput.h \
    src/logger/qslog.h \
    src/logger/qslogdest.h \
    src/models/notecache.h \
    src/models/notemodel.h \
    src/models/ntreemodel.h \
    src/oauth/oauthtokenizer.h \
    src/hunspell/spellchecker.h \
	src/qevercloud/include/qevercloud/QEverCloud.h \
	src/qevercloud/include/qevercloud/QEverCloudOAuth.h \
    src/qevercloud/include/qevercloud/DurableService.h \
    src/qevercloud/include/qevercloud/EventLoopFinisher.h \
    src/qevercloud/include/qevercloud/IInkNoteImageDownloader.h \
    src/qevercloud/include/qevercloud/INoteThumbnailDownloader.h \
    src/qevercloud/include/qevercloud/IRequestContext.h \
    src/qevercloud/include/qevercloud/NetworkProxy.h \
    src/qevercloud/include/qevercloud/RequestContextBuilder.h \
    src/qevercloud/include/qevercloud/exceptions/EDAMSystemExceptionAuthExpired.h \
    src/qevercloud/include/qevercloud/exceptions/EDAMSystemExceptionRateLimitReached.h \
    src/qevercloud/include/qevercloud/exceptions/EverCloudException.h \
    src/qevercloud/include/qevercloud/exceptions/EvernoteException.h \
    src/qevercloud/include/qevercloud/exceptions/NetworkException.h \
    src/qevercloud/include/qevercloud/exceptions/ThriftException.h \
    src/qevercloud/include/qevercloud/utility/Log.h \
    src/qevercloud/include/qevercloud/utility/Printable.h \
    src/qevercloud/include/qevercloud/utility/ToRange.h \
    src/qevercloud/include/qevercloud/OAuth.h \
    src/qevercloud/include/qevercloud/Constants.h \
    src/qevercloud/include/qevercloud/EDAMErrorCode.h \
    src/qevercloud/include/qevercloud/Fwd.h \
    src/qevercloud/include/qevercloud/exceptions/All.h \
    src/qevercloud/include/qevercloud/exceptions/EDAMInvalidContactsException.h \
    src/qevercloud/include/qevercloud/exceptions/EDAMNotFoundException.h \
    src/qevercloud/include/qevercloud/exceptions/EDAMSystemException.h \
    src/qevercloud/include/qevercloud/exceptions/EDAMUserException.h \
    src/qevercloud/include/qevercloud/exceptions/Fwd.h \
    src/qevercloud/include/qevercloud/exceptions/builders/All.h \
    src/qevercloud/include/qevercloud/exceptions/builders/EDAMInvalidContactsExceptionBuilder.h \
    src/qevercloud/include/qevercloud/exceptions/builders/EDAMNotFoundExceptionBuilder.h \
    src/qevercloud/include/qevercloud/exceptions/builders/EDAMSystemExceptionBuilder.h \
    src/qevercloud/include/qevercloud/exceptions/builders/EDAMUserExceptionBuilder.h \
    src/qevercloud/include/qevercloud/exceptions/builders/Fwd.h \
    src/qevercloud/include/qevercloud/serialization/json/Accounting.h \
    src/qevercloud/include/qevercloud/serialization/json/AccountLimits.h \
    src/qevercloud/include/qevercloud/serialization/json/AuthenticationResult.h \
    src/qevercloud/include/qevercloud/serialization/json/BootstrapInfo.h \
    src/qevercloud/include/qevercloud/serialization/json/BootstrapProfile.h \
    src/qevercloud/include/qevercloud/serialization/json/BootstrapSettings.h \
    src/qevercloud/include/qevercloud/serialization/json/BusinessInvitation.h \
    src/qevercloud/include/qevercloud/serialization/json/BusinessNotebook.h \
    src/qevercloud/include/qevercloud/serialization/json/BusinessUserAttributes.h \
    src/qevercloud/include/qevercloud/serialization/json/BusinessUserInfo.h \
    src/qevercloud/include/qevercloud/serialization/json/CanMoveToContainerRestrictions.h \
    src/qevercloud/include/qevercloud/serialization/json/Contact.h \
    src/qevercloud/include/qevercloud/serialization/json/CreateOrUpdateNotebookSharesResult.h \
    src/qevercloud/include/qevercloud/serialization/json/Data.h \
    src/qevercloud/include/qevercloud/serialization/json/EDAMInvalidContactsException.h \
    src/qevercloud/include/qevercloud/serialization/json/EDAMNotFoundException.h \
    src/qevercloud/include/qevercloud/serialization/json/EDAMSystemException.h \
    src/qevercloud/include/qevercloud/serialization/json/EDAMUserException.h \
    src/qevercloud/include/qevercloud/serialization/json/Identity.h \
    src/qevercloud/include/qevercloud/serialization/json/InvitationShareRelationship.h \
    src/qevercloud/include/qevercloud/serialization/json/LazyMap.h \
    src/qevercloud/include/qevercloud/serialization/json/LinkedNotebook.h \
    src/qevercloud/include/qevercloud/serialization/json/ManageNotebookSharesError.h \
    src/qevercloud/include/qevercloud/serialization/json/ManageNotebookSharesParameters.h \
    src/qevercloud/include/qevercloud/serialization/json/ManageNotebookSharesResult.h \
    src/qevercloud/include/qevercloud/serialization/json/ManageNoteSharesError.h \
    src/qevercloud/include/qevercloud/serialization/json/ManageNoteSharesParameters.h \
    src/qevercloud/include/qevercloud/serialization/json/ManageNoteSharesResult.h \
    src/qevercloud/include/qevercloud/serialization/json/MemberShareRelationship.h \
    src/qevercloud/include/qevercloud/serialization/json/Note.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteAttributes.h \
    src/qevercloud/include/qevercloud/serialization/json/Notebook.h \
    src/qevercloud/include/qevercloud/serialization/json/NotebookDescriptor.h \
    src/qevercloud/include/qevercloud/serialization/json/NotebookRecipientSettings.h \
    src/qevercloud/include/qevercloud/serialization/json/NotebookRestrictions.h \
    src/qevercloud/include/qevercloud/serialization/json/NotebookShareTemplate.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteCollectionCounts.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteEmailParameters.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteFilter.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteInvitationShareRelationship.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteLimits.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteList.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteMemberShareRelationship.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteMetadata.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteRestrictions.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteResultSpec.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteShareRelationshipRestrictions.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteShareRelationships.h \
    src/qevercloud/include/qevercloud/serialization/json/NotesMetadataList.h \
    src/qevercloud/include/qevercloud/serialization/json/NotesMetadataResultSpec.h \
    src/qevercloud/include/qevercloud/serialization/json/NoteVersionId.h \
    src/qevercloud/include/qevercloud/serialization/json/PublicUserInfo.h \
    src/qevercloud/include/qevercloud/serialization/json/Publishing.h \
    src/qevercloud/include/qevercloud/serialization/json/RelatedContent.h \
    src/qevercloud/include/qevercloud/serialization/json/RelatedContentImage.h \
    src/qevercloud/include/qevercloud/serialization/json/RelatedQuery.h \
    src/qevercloud/include/qevercloud/serialization/json/RelatedResult.h \
    src/qevercloud/include/qevercloud/serialization/json/RelatedResultSpec.h \
    src/qevercloud/include/qevercloud/serialization/json/Resource.h \
    src/qevercloud/include/qevercloud/serialization/json/ResourceAttributes.h \
    src/qevercloud/include/qevercloud/serialization/json/SavedSearch.h \
    src/qevercloud/include/qevercloud/serialization/json/SavedSearchScope.h \
    src/qevercloud/include/qevercloud/serialization/json/SharedNote.h \
    src/qevercloud/include/qevercloud/serialization/json/SharedNotebook.h \
    src/qevercloud/include/qevercloud/serialization/json/SharedNotebookRecipientSettings.h \
    src/qevercloud/include/qevercloud/serialization/json/SharedNoteTemplate.h \
    src/qevercloud/include/qevercloud/serialization/json/ShareRelationshipRestrictions.h \
    src/qevercloud/include/qevercloud/serialization/json/ShareRelationships.h \
    src/qevercloud/include/qevercloud/serialization/json/SyncChunk.h \
    src/qevercloud/include/qevercloud/serialization/json/SyncChunkFilter.h \
    src/qevercloud/include/qevercloud/serialization/json/SyncState.h \
    src/qevercloud/include/qevercloud/serialization/json/Tag.h \
    src/qevercloud/include/qevercloud/serialization/json/UpdateNoteIfUsnMatchesResult.h \
    src/qevercloud/include/qevercloud/serialization/json/User.h \
    src/qevercloud/include/qevercloud/serialization/json/UserAttributes.h \
    src/qevercloud/include/qevercloud/serialization/json/UserIdentity.h \
    src/qevercloud/include/qevercloud/serialization/json/UserProfile.h \
    src/qevercloud/include/qevercloud/serialization/json/UserUrls.h \
    src/qevercloud/include/qevercloud/services/Fwd.h \
    src/qevercloud/include/qevercloud/services/INoteStore.h \
    src/qevercloud/include/qevercloud/services/IUserStore.h \
    src/qevercloud/include/qevercloud/services/NoteStoreServer.h \
    src/qevercloud/include/qevercloud/services/UserStoreServer.h \
    src/qevercloud/include/qevercloud/types/Accounting.h \
    src/qevercloud/include/qevercloud/types/AccountLimits.h \
    src/qevercloud/include/qevercloud/types/All.h \
    src/qevercloud/include/qevercloud/types/AuthenticationResult.h \
    src/qevercloud/include/qevercloud/types/BootstrapInfo.h \
    src/qevercloud/include/qevercloud/types/BootstrapProfile.h \
    src/qevercloud/include/qevercloud/types/BootstrapSettings.h \
    src/qevercloud/include/qevercloud/types/BusinessInvitation.h \
    src/qevercloud/include/qevercloud/types/BusinessNotebook.h \
    src/qevercloud/include/qevercloud/types/BusinessUserAttributes.h \
    src/qevercloud/include/qevercloud/types/BusinessUserInfo.h \
    src/qevercloud/include/qevercloud/types/CanMoveToContainerRestrictions.h \
    src/qevercloud/include/qevercloud/types/Contact.h \
    src/qevercloud/include/qevercloud/types/CreateOrUpdateNotebookSharesResult.h \
    src/qevercloud/include/qevercloud/types/Data.h \
    src/qevercloud/include/qevercloud/types/Fwd.h \
    src/qevercloud/include/qevercloud/types/Identity.h \
    src/qevercloud/include/qevercloud/types/InvitationShareRelationship.h \
    src/qevercloud/include/qevercloud/types/LazyMap.h \
    src/qevercloud/include/qevercloud/types/LinkedNotebook.h \
    src/qevercloud/include/qevercloud/types/ManageNotebookSharesError.h \
    src/qevercloud/include/qevercloud/types/ManageNotebookSharesParameters.h \
    src/qevercloud/include/qevercloud/types/ManageNotebookSharesResult.h \
    src/qevercloud/include/qevercloud/types/ManageNoteSharesError.h \
    src/qevercloud/include/qevercloud/types/ManageNoteSharesParameters.h \
    src/qevercloud/include/qevercloud/types/ManageNoteSharesResult.h \
    src/qevercloud/include/qevercloud/types/MemberShareRelationship.h \
    src/qevercloud/include/qevercloud/types/Metatypes.h \
    src/qevercloud/include/qevercloud/types/Note.h \
    src/qevercloud/include/qevercloud/types/NoteAttributes.h \
    src/qevercloud/include/qevercloud/types/Notebook.h \
    src/qevercloud/include/qevercloud/types/NotebookDescriptor.h \
    src/qevercloud/include/qevercloud/types/NotebookRecipientSettings.h \
    src/qevercloud/include/qevercloud/types/NotebookRestrictions.h \
    src/qevercloud/include/qevercloud/types/NotebookShareTemplate.h \
    src/qevercloud/include/qevercloud/types/NoteCollectionCounts.h \
    src/qevercloud/include/qevercloud/types/NoteEmailParameters.h \
    src/qevercloud/include/qevercloud/types/NoteFilter.h \
    src/qevercloud/include/qevercloud/types/NoteInvitationShareRelationship.h \
    src/qevercloud/include/qevercloud/types/NoteLimits.h \
    src/qevercloud/include/qevercloud/types/NoteList.h \
    src/qevercloud/include/qevercloud/types/NoteMemberShareRelationship.h \
    src/qevercloud/include/qevercloud/types/NoteMetadata.h \
    src/qevercloud/include/qevercloud/types/NoteRestrictions.h \
    src/qevercloud/include/qevercloud/types/NoteResultSpec.h \
    src/qevercloud/include/qevercloud/types/NoteShareRelationshipRestrictions.h \
    src/qevercloud/include/qevercloud/types/NoteShareRelationships.h \
    src/qevercloud/include/qevercloud/types/NotesMetadataList.h \
    src/qevercloud/include/qevercloud/types/NotesMetadataResultSpec.h \
    src/qevercloud/include/qevercloud/types/NoteVersionId.h \
    src/qevercloud/include/qevercloud/types/PublicUserInfo.h \
    src/qevercloud/include/qevercloud/types/Publishing.h \
    src/qevercloud/include/qevercloud/types/RelatedContent.h \
    src/qevercloud/include/qevercloud/types/RelatedContentImage.h \
    src/qevercloud/include/qevercloud/types/RelatedQuery.h \
    src/qevercloud/include/qevercloud/types/RelatedResult.h \
    src/qevercloud/include/qevercloud/types/RelatedResultSpec.h \
    src/qevercloud/include/qevercloud/types/Resource.h \
    src/qevercloud/include/qevercloud/types/ResourceAttributes.h \
    src/qevercloud/include/qevercloud/types/SavedSearch.h \
    src/qevercloud/include/qevercloud/types/SavedSearchScope.h \
    src/qevercloud/include/qevercloud/types/SharedNote.h \
    src/qevercloud/include/qevercloud/types/SharedNotebook.h \
    src/qevercloud/include/qevercloud/types/SharedNotebookRecipientSettings.h \
    src/qevercloud/include/qevercloud/types/SharedNoteTemplate.h \
    src/qevercloud/include/qevercloud/types/ShareRelationshipRestrictions.h \
    src/qevercloud/include/qevercloud/types/ShareRelationships.h \
    src/qevercloud/include/qevercloud/types/SyncChunk.h \
    src/qevercloud/include/qevercloud/types/SyncChunkFilter.h \
    src/qevercloud/include/qevercloud/types/SyncState.h \
    src/qevercloud/include/qevercloud/types/Tag.h \
    src/qevercloud/include/qevercloud/types/TypeAliases.h \
    src/qevercloud/include/qevercloud/types/UpdateNoteIfUsnMatchesResult.h \
    src/qevercloud/include/qevercloud/types/User.h \
    src/qevercloud/include/qevercloud/types/UserAttributes.h \
    src/qevercloud/include/qevercloud/types/UserIdentity.h \
    src/qevercloud/include/qevercloud/types/UserProfile.h \
    src/qevercloud/include/qevercloud/types/UserUrls.h \
    src/qevercloud/include/qevercloud/types/builders/AccountingBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/AccountLimitsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/All.h \
    src/qevercloud/include/qevercloud/types/builders/AuthenticationResultBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BootstrapInfoBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BootstrapProfileBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BootstrapSettingsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BusinessInvitationBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BusinessNotebookBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BusinessUserAttributesBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/BusinessUserInfoBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/CanMoveToContainerRestrictionsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ContactBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/CreateOrUpdateNotebookSharesResultBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/DataBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/Fwd.h \
    src/qevercloud/include/qevercloud/types/builders/IdentityBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/InvitationShareRelationshipBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/LazyMapBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/LinkedNotebookBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ManageNotebookSharesErrorBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ManageNotebookSharesParametersBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ManageNotebookSharesResultBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ManageNoteSharesErrorBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ManageNoteSharesParametersBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ManageNoteSharesResultBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/MemberShareRelationshipBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteAttributesBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotebookBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotebookDescriptorBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotebookRecipientSettingsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotebookRestrictionsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotebookShareTemplateBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteCollectionCountsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteEmailParametersBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteFilterBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteInvitationShareRelationshipBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteLimitsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteListBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteMemberShareRelationshipBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteMetadataBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteRestrictionsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteResultSpecBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteShareRelationshipRestrictionsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteShareRelationshipsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotesMetadataListBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NotesMetadataResultSpecBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/NoteVersionIdBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/PublicUserInfoBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/PublishingBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/RelatedContentBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/RelatedContentImageBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/RelatedQueryBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/RelatedResultBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/RelatedResultSpecBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ResourceAttributesBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ResourceBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SavedSearchBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SavedSearchScopeBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SharedNotebookBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SharedNotebookRecipientSettingsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SharedNoteBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SharedNoteTemplateBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ShareRelationshipRestrictionsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/ShareRelationshipsBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SyncChunkBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SyncChunkFilterBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/SyncStateBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/TagBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/UpdateNoteIfUsnMatchesResultBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/UserAttributesBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/UserBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/UserIdentityBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/UserProfileBuilder.h \
    src/qevercloud/include/qevercloud/types/builders/UserUrlsBuilder.h \
    src/qevercloud/src/Future.h \
    src/qevercloud/src/Http.h \
    src/qevercloud/src/HttpRequestData.h \
    src/qevercloud/src/HttpRequestParser.h \
    src/qevercloud/src/HttpUtils.h \
    src/qevercloud/src/Impl.h \
    src/qevercloud/src/InkNoteImageDownloader.h \
    src/qevercloud/src/NetworkReplyFetcher.h \
    src/qevercloud/src/QtFutureContinuations.h \
    src/qevercloud/src/RequestContext.h \
    src/qevercloud/src/Thrift.h \
    src/qevercloud/src/exceptions/impl/EDAMInvalidContactsExceptionImpl.h \
    src/qevercloud/src/exceptions/impl/EDAMNotFoundExceptionImpl.h \
    src/qevercloud/src/exceptions/impl/EDAMSystemExceptionImpl.h \
    src/qevercloud/src/exceptions/impl/EDAMUserExceptionImpl.h \
    src/qevercloud/src/types/Types_io.h \
    src/qevercloud/src/types/impl/AccountingImpl.h \
    src/qevercloud/src/types/impl/AccountLimitsImpl.h \
    src/qevercloud/src/types/impl/AuthenticationResultImpl.h \
    src/qevercloud/src/types/impl/BootstrapInfoImpl.h \
    src/qevercloud/src/types/impl/BootstrapProfileImpl.h \
    src/qevercloud/src/types/impl/BootstrapSettingsImpl.h \
    src/qevercloud/src/types/impl/BusinessInvitationImpl.h \
    src/qevercloud/src/types/impl/BusinessNotebookImpl.h \
    src/qevercloud/src/types/impl/BusinessUserAttributesImpl.h \
    src/qevercloud/src/types/impl/BusinessUserInfoImpl.h \
    src/qevercloud/src/types/impl/CanMoveToContainerRestrictionsImpl.h \
    src/qevercloud/src/types/impl/ContactImpl.h \
    src/qevercloud/src/types/impl/CreateOrUpdateNotebookSharesResultImpl.h \
    src/qevercloud/src/types/impl/DataImpl.h \
    src/qevercloud/src/types/impl/IdentityImpl.h \
    src/qevercloud/src/types/impl/InvitationShareRelationshipImpl.h \
    src/qevercloud/src/types/impl/LazyMapImpl.h \
    src/qevercloud/src/types/impl/LinkedNotebookImpl.h \
    src/qevercloud/src/types/impl/ManageNotebookSharesErrorImpl.h \
    src/qevercloud/src/types/impl/ManageNotebookSharesParametersImpl.h \
    src/qevercloud/src/types/impl/ManageNotebookSharesResultImpl.h \
    src/qevercloud/src/types/impl/ManageNoteSharesErrorImpl.h \
    src/qevercloud/src/types/impl/ManageNoteSharesParametersImpl.h \
    src/qevercloud/src/types/impl/ManageNoteSharesResultImpl.h \
    src/qevercloud/src/types/impl/MemberShareRelationshipImpl.h \
    src/qevercloud/src/types/impl/NoteAttributesImpl.h \
    src/qevercloud/src/types/impl/NotebookImpl.h \
    src/qevercloud/src/types/impl/NotebookDescriptorImpl.h \
    src/qevercloud/src/types/impl/NotebookRecipientSettingsImpl.h \
    src/qevercloud/src/types/impl/NotebookRestrictionsImpl.h \
    src/qevercloud/src/types/impl/NotebookShareTemplateImpl.h \
    src/qevercloud/src/types/impl/NoteCollectionCountsImpl.h \
    src/qevercloud/src/types/impl/NoteImpl.h \
    src/qevercloud/src/types/impl/NoteEmailParametersImpl.h \
    src/qevercloud/src/types/impl/NoteFilterImpl.h \
    src/qevercloud/src/types/impl/NoteInvitationShareRelationshipImpl.h \
    src/qevercloud/src/types/impl/NoteLimitsImpl.h \
    src/qevercloud/src/types/impl/NoteListImpl.h \
    src/qevercloud/src/types/impl/NoteMemberShareRelationshipImpl.h \
    src/qevercloud/src/types/impl/NoteMetadataImpl.h \
    src/qevercloud/src/types/impl/NoteRestrictionsImpl.h \
    src/qevercloud/src/types/impl/NoteResultSpecImpl.h \
    src/qevercloud/src/types/impl/NoteShareRelationshipRestrictionsImpl.h \
    src/qevercloud/src/types/impl/NoteShareRelationshipsImpl.h \
    src/qevercloud/src/types/impl/NotesMetadataListImpl.h \
    src/qevercloud/src/types/impl/NotesMetadataResultSpecImpl.h \
    src/qevercloud/src/types/impl/NoteVersionIdImpl.h \
    src/qevercloud/src/types/impl/PublicUserInfoImpl.h \
    src/qevercloud/src/types/impl/PublishingImpl.h \
    src/qevercloud/src/types/impl/RelatedContentImpl.h \
    src/qevercloud/src/types/impl/RelatedContentImageImpl.h \
    src/qevercloud/src/types/impl/RelatedQueryImpl.h \
    src/qevercloud/src/types/impl/RelatedResultImpl.h \
    src/qevercloud/src/types/impl/RelatedResultSpecImpl.h \
    src/qevercloud/src/types/impl/ResourceAttributesImpl.h \
    src/qevercloud/src/types/impl/ResourceImpl.h \
    src/qevercloud/src/types/impl/SavedSearchImpl.h \
    src/qevercloud/src/types/impl/SavedSearchScopeImpl.h \
    src/qevercloud/src/types/impl/SharedNotebookImpl.h \
    src/qevercloud/src/types/impl/SharedNotebookRecipientSettingsImpl.h \
    src/qevercloud/src/types/impl/SharedNoteImpl.h \
    src/qevercloud/src/types/impl/SharedNoteTemplateImpl.h \
    src/qevercloud/src/types/impl/ShareRelationshipRestrictionsImpl.h \
    src/qevercloud/src/types/impl/ShareRelationshipsImpl.h \
    src/qevercloud/src/types/impl/SyncChunkImpl.h \
    src/qevercloud/src/types/impl/SyncChunkFilterImpl.h \
    src/qevercloud/src/types/impl/SyncStateImpl.h \
    src/qevercloud/src/types/impl/TagImpl.h \
    src/qevercloud/src/types/impl/UpdateNoteIfUsnMatchesResultImpl.h \
    src/qevercloud/src/types/impl/UserAttributesImpl.h \
    src/qevercloud/src/types/impl/UserImpl.h \
    src/qevercloud/src/types/impl/UserIdentityImpl.h \
    src/qevercloud/src/types/impl/UserProfileImpl.h \
    src/qevercloud/src/types/impl/UserUrlsImpl.h \
    src/qevercloud/src/oauth/AbstractOAuthEngine.h \
    src/qevercloud/src/oauth/NetworkCookieJar.h \
    src/qevercloud/src/oauth/Utils.h \
    src/qevercloud/src/oauth/OAuthSystemBrowser.h \
    src/qevercloud/src/Qt5Promise.h \
    src/qevercloud/src/Qt5FutureHelpers.h \
    src/reminders/reminderevent.h \
    src/reminders/remindermanager.h \
    src/settings/accountsmanager.h \
    src/settings/colorsettings.h \
    src/settings/filemanager.h \
    src/settings/startupconfig.h \
    src/sql/configstore.h \
    src/sql/databaseconnection.h \
    src/sql/databaseupgrade.h \
    src/sql/datastore.h \
    src/sql/favoritesrecord.h \
    src/sql/favoritestable.h \
    src/sql/filewatchertable.h \
    src/sql/linkednotebooktable.h \
    src/sql/notebooktable.h \
    src/sql/notemetadata.h \
    src/sql/notetable.h \
    src/sql/nsqlquery.h \
    src/sql/resourcetable.h \
    src/sql/searchtable.h \
    src/sql/sharednotebooktable.h \
    src/sql/tagtable.h \
    src/sql/usertable.h \
    src/html/attachmenticonbuilder.h \
    src/html/enmlformatter.h \
    src/html/NoteFormatterBase.h \
    src/html/noteformatter.h \
    src/html/tagscanner.h \
    src/html/thumbnailer.h \
    src/threads/browserrunner.h \
    src/threads/counterrunner.h \
    src/threads/indexrunner.h \
    src/threads/syncrunner.h \
    src/utilities/crossmemorymapper.h \
    src/utilities/debugtool.h \
    src/utilities/encrypt.h \
    src/utilities/mimereference.h \
    src/utilities/noteindexer.h \
    src/utilities/nuuid.h \
    src/utilities/NixnoteStringUtils.h \
    src/utilities/pixelconverter.h \
    src/watcher/filewatcher.h \
    src/watcher/filewatchermanager.h \
    src/xml/batchimport.h \
    src/xml/exportdata.h \
    src/xml/importdata.h \
    src/xml/importenex.h \
    src/xml/xmlhighlighter.h \
    src/quentier/utility/StringUtils.h \
    src/quentier/utility/StringUtils_p.h

# http://doc.qt.io/qt-5/qmake-function-reference.html#str-member-arg-start-end
# $$left(VAR, len)
#left = $$str_member(VAR, 0, $$num_add($$len, -1))

# get g++ version
gcc {
    COMPILER_VERSION = $$system($$QMAKE_CXX " -dumpversion")
    COMPILER_MAJOR_VERSION1 = $$split(COMPILER_VERSION, ".")
    COMPILER_MAJOR_VERSION = $$first(COMPILER_MAJOR_VERSION1)
    message("$$TARGET: Compiler version $$COMPILER_MAJOR_VERSION")
    COMPILER_CONFIG = g++$$COMPILER_MAJOR_VERSION
    message("$$TARGET: Adding compiler config $$COMPILER_CONFIG")
    CONFIG += $$COMPILER_CONFIG
}

QMAKE_CXXFLAGS += -std=c++14 -g -O2  -Wformat -Werror=format-security
linux:QMAKE_LFLAGS += -Wl,-Bsymbolic-functions -Wl,-z,relro

g++4 {
  # this is a guess, but "stack-protector-strong" may not be available yet
  QMAKE_CXXFLAGS += -fstack-protector
} else {
  QMAKE_CXXFLAGS += -fstack-protector-strong
}


win32:QMAKE_CXXFLAGS +=-g -O2 --param=ssp-buffer-size=4 -Wformat -Werror=format-security
win32:QMAKE_LFLAGS += -Wl,-Bsymbolic-functions
win32:QMAKE_LFLAGS += -fstack-protector-strong
win32:DEFINES += SMTP_BUILD

isEmpty(PREFIX) {
  PREFIX = /usr
}

binary.path = $${PREFIX}/bin
binary.files = $${DESTDIR}/$${TARGET}
binary.CONFIG = no_check_exist
message("Target binary: $${binary.files}")

desktop.path = $${PREFIX}/share/applications
desktop.files = $${TARGET}.desktop

icons.path = $${PREFIX}/share/icons
icons.files = resources/icons/*

images.path = $${PREFIX}/share/$$TARGET/images
images.files = resources/images/*

java.path = $${PREFIX}/share/$$TARGET/java
java.files = java/crypto.jar

help.path = $${PREFIX}/share/$$TARGET/help
help.files = help/*

textfiles.path = $${PREFIX}/share/$$TARGET
textfiles.files = $$PWD/shortcuts.txt $$PWD/themes.ini $$PWD/LICENSE $$PWD/colors.txt \
                  $${DESTDIR}/version/build-version.txt $${DESTDIR}/version/version.txt \
                  $$PWD/resources/sample_exits
textfiles.CONFIG = no_check_exist

docs.path = $${PREFIX}/share/doc/$$TARGET
docs.files = $$PWD/debian/copyright $$PWD/changelog.txt $$PWD/README.md $$PWD/docs/license.html

VERSION_FILES = $$PWD/changelog.txt
fullversion.input = VERSION_FILES
fullversion.output  = $${DESTDIR}/version/build-version.txt
fullversion.commands = ./development/create-build-version.sh $${DESTDIR}
fullversion.CONFIG += no_link no_check_exist

fullversion2.input = VERSION_FILES
fullversion2.output  = $${DESTDIR}/version/version.txt
fullversion2.commands = ./development/create-build-version.sh $${DESTDIR}
fullversion2.CONFIG += no_link no_check_exist

QMAKE_EXTRA_COMPILERS += fullversion fullversion2
PRE_TARGETDEPS += $$DESTDIR/version/build-version.txt $$DESTDIR/version/version.txt

man.path = $${PREFIX}/share/man/man1
man.files = docs/nixnote2.1


# compile the translation files

TRANSLATIONS = \
    translations/nixnote2_cs_CZ.ts \
    translations/nixnote2_de.ts    \
    translations/nixnote2_en_GB.ts \
    translations/nixnote2_ca.ts    \
    translations/nixnote2_da.ts    \
    translations/nixnote2_es.ts    \
    translations/nixnote2_ja.ts    \
    translations/nixnote2_pt.ts    \
    translations/nixnote2_sk.ts    \
    translations/nixnote2_zh_TW.ts \
    translations/nixnote2_fr.ts    \
    translations/nixnote2_pl.ts    \
    translations/nixnote2_ru.ts    \
    translations/nixnote2_zh_CN.ts \
    translations/nixnote2_it.ts

TRANSLATION_TARGET_DIR = $${DESTDIR}/translations
TRANSLATIONS_OUT = \
    $$TRANSLATION_TARGET_DIR/nixnote2_cs_CZ.qm \
    $$TRANSLATION_TARGET_DIR/nixnote2_de.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_en_GB.qm \
    $$TRANSLATION_TARGET_DIR/nixnote2_ca.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_da.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_es.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_ja.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_pt.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_sk.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_zh_TW.qm \
    $$TRANSLATION_TARGET_DIR/nixnote2_fr.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_pl.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_ru.qm    \
    $$TRANSLATION_TARGET_DIR/nixnote2_zh_CN.qm \
    $$TRANSLATION_TARGET_DIR/nixnote2_it.qm

isEmpty(QMAKE_LRELEASE) {
    win32:LANGREL = $$[QT_INSTALL_BINS]\lrelease.exe
    else:LANGREL = $$[QT_INSTALL_BINS]/lrelease
}
langrel.input = TRANSLATIONS
langrel.output = $$TRANSLATION_TARGET_DIR/${QMAKE_FILE_BASE}.qm
langrel.commands = \
    $$LANGREL -compress -nounfinished -removeidentical ${QMAKE_FILE_IN} \
          -qm $$TRANSLATION_TARGET_DIR/${QMAKE_FILE_BASE}.qm
langrel.CONFIG += no_link
QMAKE_EXTRA_COMPILERS += langrel
PRE_TARGETDEPS += $$TRANSLATIONS_OUT

translations.files = $$TRANSLATION_TARGET_DIR
translations.CONFIG = no_check_exist


mac {
    ICON = resources/images/NixNote2.icns

    # we go for an appbundle that contains all resources (except
    # the shared library dependencies - use macdeployqt for those).
    images.path = Contents/Resources
    images.files = resources/images
    java.path = Contents/Resources
    java.files = java
    textfiles.path = Contents/Resources
    translations.path = Contents/Resources/translations
    translations.files = $$TRANSLATIONS_OUT
    docs.path = Contents/Resources/doc


    help.path = Contents/Resources
    help.files = help

    QMAKE_BUNDLE_DATA += images java translations help textfiles docs
    #INSTALLS = binary
} else {
    translations.path = $${PREFIX}/share/$$TARGET

    INSTALLS = binary desktop images java help textfiles docs man translations icons
}
