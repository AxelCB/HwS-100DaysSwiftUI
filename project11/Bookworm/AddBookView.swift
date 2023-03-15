//
//  AddBookView.swift
//  Bookworm
//
//  Created by Axel Collard Bovy on 4/2/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var showingInvalidAlert = false

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        guard validateBook() else {
                            showingInvalidAlert = true
                            return
                        }
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date.now

                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Invalid book", isPresented: $showingInvalidAlert) {
                Button("Ok", role: .cancel) { }
            } message: {
                Text("Must complete all fields to save a book")
            }
        }
    }

    private func validateBook() -> Bool {
        title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        author = author.trimmingCharacters(in: .whitespacesAndNewlines)
        review = review.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty, !author.isEmpty, !review.isEmpty else {
            return false
        }
        guard genres.contains(genre) else {
            return false
        }
        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .environment(\.managedObjectContext, DataController().container.viewContext)
    }
}
