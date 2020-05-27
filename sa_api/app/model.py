import json

import torch
import torch.nn.functional as F
from torch import nn
from transformers import BertTokenizer, BertModel

CLASS_NAMES = ["negative", "positive"]


class Classifier(nn.Module):
    def __init__(self, n_classes):
        super(Classifier, self).__init__()
        self.bert = BertModel.from_pretrained("bert-base-cased")
        self.drop = nn.Dropout(p=0.3)
        self.out = nn.Linear(self.bert.config.hidden_size, n_classes)

    def forward(self, input_ids, attention_mask):
        _, pooled_output = self.bert(
            input_ids=input_ids, attention_mask=attention_mask)
        output = self.drop(pooled_output)
        return self.out(output)


class Model:
    def __init__(self):
        self.device = torch.device("cpu")
        self.tokenizer = BertTokenizer.from_pretrained("bert-base-cased")

        classifier = Classifier(2)
        classifier.load_state_dict(torch.load(
            "assets/model.pt", map_location=self.device))
        classifier = classifier.eval()
        self.classifier = classifier.to(self.device)

    def analyse(self, text):
        encoded = self.tokenizer.encode_plus(
            text,
            max_length=250,
            add_special_tokens=True,
            return_token_type_ids=False,
            pad_to_max_length=True,
            return_attention_mask=True,
            return_tensors="pt",
        )
        input_ids = encoded["input_ids"].to(self.device)
        attention_mask = encoded["attention_mask"].to(self.device)

        with torch.no_grad():
            probabilities = F.softmax(self.classifier(
                input_ids, attention_mask), dim=1)
        _, result = torch.max(probabilities, dim=1)
        result = result.cpu().item()
        return (
            CLASS_NAMES[result]
        )


model = Model()


def get_model():
    return model
