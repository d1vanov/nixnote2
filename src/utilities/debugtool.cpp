/*********************************************************************************
NixNote - An open-source client for the Evernote service.
Copyright (C) 2015 Randy Baumgarte

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

#include "debugtool.h"
#include "src/logger/qslog.h"


DebugTool::DebugTool() = default;


//************************************
// Dump a tag to the debug log
//************************************
void DebugTool::dumpTag(Tag tag) {
    QLOG_DEBUG() << "*** Dumping Tag ***";
    dumpField(tag.guid(), "guid");
    dumpField(tag.name(), "name");
    dumpField(tag.parentGuid(), "parent");
    dumpField(tag.updateSequenceNum(), "USN");
    QLOG_DEBUG() << "*** Tag Dump complete ***";
}


//************************************
// Dump a saved search to the debug log
//************************************
void DebugTool::dumpSavedSearch(SavedSearch &search) {
    QLOG_DEBUG() << "*** Dumping Saved Search ***";
    dumpField(search.guid(), "guid");
    dumpField(search.name(), "name");
    dumpField(search.query(), "query");
    dumpField(search.updateSequenceNum(), "USN");
    if (search.format().has_value())
        QLOG_DEBUG() << "format:" << *search.format() << ":";
    else QLOG_DEBUG() << "format not found.";
    if (search.scope().has_value()) {
        SavedSearchScope scope = *search.scope();
        dumpField(scope.includeAccount(), "includeAccount");
        dumpField(scope.includePersonalLinkedNotebooks(), "includePersonalLinkedNotebooks");
        dumpField(scope.includeBusinessLinkedNotebooks(), "includeBusinessLinkedNotebooks");
    } else QLOG_DEBUG() << "search scope not found.";

    QLOG_DEBUG() << "*** Saved Search Dump Complete ***";
}


//************************************
// Dump a note to the debug log
//************************************
void DebugTool::dumpNote(const Note &note) {
    if (!QLOG_IS_DEBUG) {
        return;
    }

    QLOG_DEBUG() << ">>>>>>>>> note guid=" << note.guid().value_or(QString{});
    dumpField(note.active(), "active");
    dumpField(note.title(), "title");
    dumpField(note.content(), "content");
    dumpField(note.contentHash(), "contentHash", true);
    dumpField(note.contentLength(), "contentLength");
    dumpField(note.created(), "created");
    dumpField(note.updated(), "updated");
    dumpField(note.deleted(), "deleted");
    dumpField(note.updateSequenceNum(), "USN");
    dumpField(note.tagGuids(), "tag guids");
    dumpField(note.tagNames(), "tag names");

    if (!note.attributes().has_value()) {
        QLOG_DEBUG() << "no note attributes found.";
    } else {
        const NoteAttributes & attributes = *note.attributes();
        dumpField(attributes.subjectDate(), "subject date");
        dumpField(attributes.latitude(), "latitude");
        dumpField(attributes.longitude(), "longitude");
        dumpField(attributes.altitude(), "altitude");
        dumpField(attributes.author(), "author");
        dumpField(attributes.source(), "source");
        dumpField(attributes.sourceURL(), "sourceURL");
        dumpField(attributes.sourceApplication(), "sourceApplication");
        dumpField(attributes.shareDate(), "shareDate");
        dumpField(attributes.reminderOrder(), "reminderOrder");
        dumpField(attributes.reminderDoneTime(), "reminderDoneTime");
        dumpField(attributes.reminderTime(), "reminderTime");
        dumpField(attributes.placeName(), "placeName");
        dumpField(attributes.contentClass(), "contentClass");
        dumpField(attributes.lastEditedBy(), "lastEditedBy");
        dumpField(attributes.creatorId(), "creatorId");
        dumpField(attributes.lastEditorId(), "lastEditorId");
    }
    dumpNoteResources(note);

    QLOG_DEBUG() << "<<<<<<<<< note guid=" << note.guid().value_or(QString{});
}

void DebugTool::dumpNoteResources(const Note &note) {
    if (note.resources().has_value()) {
        const QList<Resource> & resources = *note.resources();
        int resourceCount = resources.size();
        for (int i = 0; i < resourceCount; i++) {
            QLOG_DEBUG() << "resource #" << (i + 1) << "/" << resourceCount;
            dumpResource(resources[i]);
        }
    }
}


//************************************
// Dump a resource to the debug log
//************************************
void DebugTool::dumpResource(Resource r) {
    QLOG_DEBUG() << "guid=" << r.guid().value_or(QString{})
                 << ", noteGuid=" << r.noteGuid().value_or(QString{})
                 << ", mime=" << r.mime().value_or(QString{})
                 << ", width=" << (r.width().has_value() ? QString::number(*r.width()) : QString{})
                 << ", height=" << (r.height().has_value() ? QString::number(*r.height()) : QString{})
                 << ", duration=" << (r.duration().has_value() ? QString::number(*r.duration()) : QString{})
                 << ", active=" << (r.active().has_value() ? (*r.active() ? "true" : "false") : "")
                 << ", updateSequenceNum=" << (r.updateSequenceNum().has_value() ? QString::number(*r.updateSequenceNum()) : QString{});

    if (r.data().has_value()) {
        QLOG_DEBUG() << "resource data:";
        dumpData(*r.data());
    }
    if (r.recognition().has_value()) {
        QLOG_DEBUG() << "resource recognition data:";
        dumpData(*r.recognition());
    }
    if (r.alternateData().has_value()) {
        QLOG_DEBUG() << "resource alternate data:";
        dumpData(*r.alternateData());
    }
}


//******************************************
// Dump a generic data segment to the log
//******************************************
void DebugTool::dumpData(Data d) {
    dumpField(d.bodyHash(), "bodyHash", true);
    dumpField(d.size(), "size");
}


//************************************
// Dump a notebook to the log
//************************************
void DebugTool::dumpNotebook(Notebook n) {
    QLOG_DEBUG() << "*** Dumping Notebook ***";
    dumpField(n.guid(), "guid");
    dumpField(n.name(), "name");
    dumpField(n.updateSequenceNum(), "USN");
    dumpField(n.defaultNotebook(), "defaultNotebook");
    dumpField(n.serviceCreated(), "serviceCreated");
    dumpField(n.serviceUpdated(), "serviceUpdate");
    dumpField(n.stack(), "stack");
    dumpField(n.published(), "published");
    if (n.publishing().has_value()) {
        QLOG_DEBUG() << "publishing data:";
        const Publishing & p = *n.publishing();
        dumpField(p.uri(), "uri");
        if (p.order())
        {
            QLOG_DEBUG() << "order:" << *p.order();
        }
        dumpField(p.publicDescription(), "publicDescription");
    } else QLOG_DEBUG() << "publishing data not found";
    if (n.businessNotebook().has_value()) {
        QLOG_DEBUG() << "businessnotebook data:";
        const BusinessNotebook & b = *n.businessNotebook();
        dumpField(b.notebookDescription(), "notebookDescription");
        dumpField(b.recommended(), "recommended");
        if (b.privilege().has_value()) {
            int i = static_cast<int>(*b.privilege());
            QLOG_DEBUG() << "privilege:" << i;
        }
    } else {
        QLOG_DEBUG() << "businessnotebooek data not found.";
    }
    QLOG_DEBUG() << "*** Notebook Dump Complete ***";
}




//*******************************************************
//* The remainder of these methods are generic
//* functions called by the functions above. They
//* all work pretty much the same.  They just accept a
//* value and, if it is set, dump the contents to the
//* debug log.
//*******************************************************

void DebugTool::dumpField(std::optional<QString> field, QString name) {
    if (field.has_value()) {
        const QString &fieldValue = *field;
        if (fieldValue.length() > 100) {
            QString fname = QString("attr-").append(name);
            // just a hack for better logging
            if (name == "content") {
                fname = "note-content.xml";
            }
            QLOG_DEBUG_FILE(fname, *field);
        } else {
            QLOG_DEBUG() << name << ":" << fieldValue << ":";
        }
    }
}


void DebugTool::dumpField(std::optional<bool> field, QString name) {
    if (field.has_value()) {
        QLOG_DEBUG() << name << ":" << *field << ":";
    }
}


void DebugTool::dumpField(std::optional<double> field, QString name) {
    if (field.has_value()) {
        QLOG_DEBUG() << name << ":" << *field << ":";
    }
}


void DebugTool::dumpField(std::optional<qint32> field, QString name) {
    if (field.has_value()) {
        QLOG_DEBUG() << name << ":" << *field << ":";
    }
}


void DebugTool::dumpField(std::optional<long long> field, QString name) {
    if (field.has_value()) {
        QLOG_DEBUG() << name << ":" << *field << ":";
    }
}


void DebugTool::dumpField(std::optional<short int> field, QString name) {
    if (field.has_value()) {
        QLOG_DEBUG() << name << ":" << *field << ":";
    }
}


void DebugTool::dumpField(std::optional<QByteArray> field, QString name, bool hexValue) {
    if (field.has_value()) {
        if (hexValue) {
            const QByteArray & hex = *field;
            QLOG_DEBUG() << name << ":" << hex.toHex() << ":";
        } else {
            QLOG_DEBUG() << name << ":" << *field << ":";
        }
    }
}


void DebugTool::dumpField(std::optional<QStringList> field, QString name) {
    if (!field.has_value()) {
        QLOG_DEBUG() << name << " is empty (QStringList)";
        return;
    }

    const QStringList & fields = *field;
    QLOG_DEBUG() << name << " has " << fields.size() << " entries.";
    for (int i = 0; i < fields.size(); i++) {
        QLOG_DEBUG() << "#" << i << ":" << fields[i];
    }
}


void DebugTool::dumpField(std::optional<QList<QString> > field, QString name) {
    if (!field.has_value()) {
        QLOG_DEBUG() << name << " is empty (QList<QString>)";
        return;
    }

    const QList<QString> & fields = *field;
    QLOG_DEBUG() << name << " has " << fields.size() << " entries.";
    for (int i = 0; i < fields.size(); i++) {
        QLOG_DEBUG() << "#" << i << ":" << fields[i];
    }
}

