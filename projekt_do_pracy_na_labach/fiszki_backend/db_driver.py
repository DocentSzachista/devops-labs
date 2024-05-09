import motor.motor_asyncio
from bson.objectid import ObjectId
from models import Collection, FlashCard
import os 


db_url = os.environ.get("DATABASE_URL", "mongodb://localhost:27017")


client = motor.motor_asyncio.AsyncIOMotorClient(db_url, uuidRepresentation='standard')
database = client.students
collections = database.get_collection("collections")

async def add_collection(collection: Collection):
    print(collection.flashCards)
    new_collection = await collections.insert_one(
        collection.model_dump(exclude=["_id", "id"])
    )
    created_collection = await collections.find_one(
        {"_id": new_collection.inserted_id}
    )
    return created_collection

async def list_collections():
    return await collections.find({}, {"flashCards": False}).to_list(1000)

async def list_flashcards_from_collection(collection_id: str):
    return await collections.find_one({"_id": ObjectId(collection_id)}, {"flashCards": 1})


async def add_flashcard_to_collection(flashcard: FlashCard, collection_id: str):
    pass 
