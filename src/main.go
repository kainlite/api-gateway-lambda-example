package main

import (
	"context"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

//  "github.com/aws/aws-sdk-go-v2/aws/external"
//	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"

// func validateAccount(email string, code string, ctx context.Context) string {
//	cfg, err := external.LoadDefaultAWSConfig()
//	if err != nil {
//		log.Fatal(err)
//	}

//	cognito := cognitoidentityprovider.New(cfg)
//	req := cognito.ConfirmSignUpRequest(&cognitoidentityprovider.ConfirmSignUpInput{
//		ClientId:         aws.String(os.Getenv("COGNITO_CLIENT_ID")),
//		Username:         aws.String(email),
//		ConfirmationCode: aws.String(code),
//	})

//	var res string
//	if err != nil {
//		res, err := req.Send(ctx)
//		log.Fatal(res, err)
//	}

//	return res
// }

type Response events.APIGatewayProxyResponse

// type RequestData struct {
//	Email string
//	Code  string
// }

func Handler(ctx context.Context, request events.APIGatewayProxyRequest) (Response, error) {
	// fmt.Printf("Request: %+v\n", request)

	// fmt.Printf("Processing request data for request %s.\n", request.RequestContext.RequestID)

	// fmt.Printf("Body size = %d.\n", len(request.Body))
	// var requestData RequestData
	// json.Unmarshal([]byte(request.Body), &requestData)

	// fmt.Printf("RequestData: %+v", requestData)
	// var result string
	// if len(requestData.Email) > 0 && len(requestData.Code) > 0 {
	//	result = validateAccount(requestData.Email, requestData.Code, ctx)
	// }

	result := "Hello from golang"

	resp := Response{
		StatusCode:      200,
		IsBase64Encoded: false,
		Body:            result,
		Headers: map[string]string{
			"Content-Type":   "application/json",
			"X-Lambda-Reply": "mylambda",
		},
	}

	return resp, nil
}

func main() {
	lambda.Start(Handler)
}
