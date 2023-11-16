import Fluent
import FluentSQLiteDriver
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  // uncomment to serve files from /Public folder
  // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

  app.migrations.add(CreateCategory())
  app.migrations.add(CreateQuestion())
  app.migrations.add(CreateAnswer())
  app.migrations.add(Seed())

  // register routes
  try routes(app)
}
