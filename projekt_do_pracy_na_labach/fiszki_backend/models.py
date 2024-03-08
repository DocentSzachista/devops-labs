from pydantic import BaseModel, Field
from typing import Optional, List, Union
from typing_extensions import Annotated
from uuid import UUID, uuid4
from pydantic.functional_validators import BeforeValidator


PyObjectId = Annotated[str, BeforeValidator(str)]

class AnswerTemplate(BaseModel):
    """Abstract class to be extended by each answer types that will be supported"""
    answer: str 


class MarkedAnswer(AnswerTemplate):
    """Pydantic model to store answer that requires from user to mark it"""
    isCorrect: bool 

class InputAnswer(AnswerTemplate):
    """Pydantic model to store answer that requires user to input it"""
    pass 

class FlashCard(BaseModel):
    id: Optional[UUID] = Field(default=uuid4())
    question: str = Field(...)
    answers: List[Union[MarkedAnswer, InputAnswer]] = Field(...)
    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "question": "What do you want from your life",
                    "answers": [
                                {
                                    "answer": "To be cool",
                                    "isCorrect": True,
                                },
                                {
                                    "answer": "To be bad",
                                    "isCorrect": False,
                                },
                                {
                                    "answer": "To be happy",
                                    "isCorrect": True,
                                }
                            ]
                }
            ]
        }
    }



class Collection(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    user_id: str = Field(...)
    title : str = Field(...)
    isPublic: bool = Field(default=False)
    tags: Optional[List[str]] = Field(default=[]) 
    flashCards: Optional[List[FlashCard]] = Field(default=[])
    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "title": "Wanna pass thank you",
                    "isPublic": True,
                    "tags": ["tag1", "tag2", "tag3"],
                    "flashCards" : [
                        {
                            "question": "WHat is the reason that you are here",
                            "answers": [
                                {
                                    "answer": "To be cool",
                                    "isCorrect": True,
                                },
                                {
                                    "answer": "To be bad",
                                    "isCorrect": False,
                                },
                                {
                                    "answer": "To be happy",
                                    "isCorrect": True,
                                }
                            ]
                        }
                    ],
                    "user_id": "-1"
                },
            ]
        }
    }



class CollectionList(BaseModel):

    collections: List[Collection]


class FlascCardList(BaseModel):
    
    flashCards: List[FlashCard]
