from fastapi import APIRouter
from typing import List
from models import * 
from db_driver import add_collection, list_collections, list_flashcards_from_collection
from logger import LOGGER
router = APIRouter(
    prefix="/collections",
    tags=["collections"],
    responses={404: {"description": "Not found"}}
)

@router.get("/", response_model=CollectionList)
async def get_collections():
    """Retrieve collections that are public or belong to the user."""
    LOGGER.info("Fetching collections")
    return  CollectionList (collections=await list_collections())

@router.get("/{collection_id}/flashcard", response_model=FlascCardList)
async def get_flashcards_from_collection(collection_id: str):
    """Retrieve flashcards from the following colection"""
    flash_cards = await list_flashcards_from_collection(collection_id)
    LOGGER.info("Fetching flashcards") 
    return FlascCardList(flashCards = flash_cards['flashCards'] if flash_cards is not None else []) 


@router.post("/{collection_id}/addFlashCard")
async def post_flashcard(flash_card: FlashCard):
    LOGGER.warning("Called unimplemented function")
    raise NotImplemented("TODO: implement")

@router.post("", response_model=Collection)
async def post_collection(collection: Collection):
    LOGGER.info("adding new collection")
    return await add_collection(collection)


