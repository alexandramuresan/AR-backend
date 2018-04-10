import App
import PostgreSQLProvider

let config = try Config()
try config.addProvider(PostgreSQLProvider.Provider.self)
config.preparations.append(User.self)
config.preparations.append(BuildingPhoto.self)
config.preparations.append(ArchitectureStyle.self)
try config.setup()

let drop = try Droplet(config)
try drop.setup()

let userRequest = UserRequest(drop: drop)
userRequest.signInRequest()
userRequest.updateProfilePictureRequest()

let photoRequest = BuildingPhotoRequest(drop: drop)
photoRequest.uploadPhoto()
photoRequest.getPhotos()

let stylesRequest = ArchitectureStyleRequest(drop: drop)
stylesRequest.getStyles()
try drop.run()
