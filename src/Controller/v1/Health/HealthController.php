<?php

declare(strict_types=1);

namespace App\Controller\v1\Health;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

use function Safe\json_encode;

#[Route('/v1', name: 'v1_healthcheck_')]
class HealthController extends AbstractController
{
    /**
     * Returns the default value pong if the route is reachable
     */
    #[Route('/ping', name: 'ping', methods: [Request::METHOD_GET])]
    public function ping(): Response
    {
        return new Response('pong', Response::HTTP_OK, ['Content-Type' => 'text/plain']);
    }

    #[Route('/health', name: 'health', methods: [Request::METHOD_GET])]
    public function health(): Response
    {
        return new Response('health', Response::HTTP_OK, ['Content-Type' => 'text/plain']);
    }
}
