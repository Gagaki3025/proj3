<?php

use Illuminate\Support\Facades\Route;
use OpenAI\Laravel\Facades\OpenAI;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/ai', function () {
    $result = OpenAI::chat()->create([
//      'model' => 'gpt-3.5-turbo',  $$$
//      'model' => 'gpt4free',
//      'model' => 'mistralai/mistral-7b-instruct',
//      'model' => 'gemini-pro',
        'model' => 'deepseek/deepseek-chat-v3-0324:free',
        'messages' => [
//            ['role' => 'user', 'content' => 'Скажи привет. выведи число пи с точностью до 50 знака и ряд фибоначи 10 чисел, и какая погода в киеве сейчас? выведи график y=x*x+3'],
//            ['role' => 'user', 'content' => 'какой номер запчасти правого рычага оригинального? mitsubisi xl 2007 '],
            ['role' => 'user', 'content' => 'kia rio 3 схема электропровдки двигателя'],
        ],
    ]);

    return $result->choices[0]->message->content;
}); 













