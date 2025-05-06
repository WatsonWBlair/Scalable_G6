from sklearn.model_selection import train_test_split
from sklearn import metrics
import matplotlib.pyplot as plt



class ModelEvaluationHarness:
    def __init__(self, model, model_name: str, features, targets):
        self.features = features
        self.targets = targets
        self.X_train = None
        self.X_test = None
        self.y_train = None
        self.y_test = None
        self.name = model_name
        self.model = model
        self.evaluation = None
        self.fig = None
        return
    
    def setData(self, features, targets):
        self.features = features
        self.targets = targets
        return

    
    def splitData(self, features=False, targets=False, test_size = 0.33, random_state = 42):
        X_train, X_test, y_train, y_test = train_test_split(
            features if features else self.features,
            targets if targets else self.targets,
            test_size = test_size,
            random_state = random_state
            )

        self.X_train = X_train
        self.X_test = X_test
        self.y_test = y_test
        self.y_train = y_train
        return
    
    def predict(self, features=False):
        self.y_predicted = self.model.predict(self.X_test if not features else features)
        return self.y_predicted
    
    def train(self, feature = False, target = False):
        self.model.fit(
            self.X_train if not feature else feature,
            self.y_train if not target else target
            )
        return
    
    def evaluate(self):
        # self.y_predicted = self.model.predict(self.X_test)
        fpr, tpr, thresholds = metrics.roc_curve(self.y_test, self.y_predicted)
        self.evaluation = {
            'accuracy': metrics.accuracy_score(self.y_test, self.y_predicted),
            'precision': metrics.precision_score(self.y_test, self.y_predicted),
            'recall': metrics.recall_score(self.y_test, self.y_predicted),
            'f1': metrics.f1_score(self.y_test, self.y_predicted),
            'classificationReport': metrics.classification_report(self.y_test, self.y_predicted),
            'confusionMatrix': metrics.confusion_matrix(self.y_test, self.y_predicted),
            'roc_curve': {
                'fpr': fpr,
                'tpr': tpr,
                'thresholds': thresholds
            },
            'auc': metrics.auc(fpr, tpr),
        }
        return self.evaluation
    
    def graphROC(self):
        self.fig, [self.ax_roc, self.ax_det] = plt.subplots(1, 2, figsize=(11, 5))

        metrics.RocCurveDisplay.from_estimator(self.model, self.X_test, self.y_test, ax=self.ax_roc, name=self.name)
        metrics.DetCurveDisplay.from_estimator(self.model, self.X_test, self.y_test, ax=self.ax_det, name=self.name)

        self.ax_roc.set_title("Receiver Operating Characteristic (ROC) curves")
        self.ax_det.set_title("Detection Error Tradeoff (DET) curves")

        self.ax_roc.grid(linestyle="--")
        self.ax_det.grid(linestyle="--")

        plt.legend()
        return


class DataEvaluationWrapper:
    def __init__(self, model, model_name: str, featureSets):
        self.featureSets = featureSets
        self.name = model_name
        self.model = model
        self.evaluation = None
        self.fig = None
        return


    # def splitData(self, features=False, targets=False, test_size = 0.33, random_state = 42):
    #     X_train, X_test, y_train, y_test = train_test_split(
    #         features if features else self.features,
    #         targets if targets else self.targets,
    #         test_size = test_size,
    #         random_state = random_state
    #         )

    #     self.X_train = X_train
    #     self.X_test = X_test
    #     self.y_test = y_test
    #     self.y_train = y_train
    #     return
    
    # def predict(self, features=False):
    #     self.y_predicted = self.model.predict(self.X_test if not features else features)
    #     return self.y_predicted
    
    # def train(self, feature = False, target = False):
    #     self.model.fit(
    #         self.X_train if not feature else feature,
    #         self.y_train if not target else target
    #         )
    #     return
    
    # def evaluate(self):
    #     for name, data in self.featureSets.items():
            
    #     # self.y_predicted = self.model.predict(self.X_test)
    #     fpr, tpr, thresholds = metrics.roc_curve(self.y_test, self.y_predicted)
    #     self.evaluation = {
    #         'accuracy': metrics.accuracy_score(self.y_test, self.y_predicted),
    #         'precision': metrics.precision_score(self.y_test, self.y_predicted),
    #         'recall': metrics.recall_score(self.y_test, self.y_predicted),
    #         'f1': metrics.f1_score(self.y_test, self.y_predicted),
    #         'classificationReport': metrics.classification_report(self.y_test, self.y_predicted),
    #         'confusionMatrix': metrics.confusion_matrix(self.y_test, self.y_predicted),
    #         'roc_curve': {
    #             'fpr': fpr,
    #             'tpr': tpr,
    #             'thresholds': thresholds
    #         },
    #         'auc': metrics.auc(fpr, tpr),
    #     }
    #     return self.evaluation